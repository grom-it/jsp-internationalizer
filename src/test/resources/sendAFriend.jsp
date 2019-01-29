<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="springtags" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/expose/core/page" %>

<%--@elvariable id="expose" type="de.is24.search.expose.domain.Expose"--%>
<%--@elvariable id="clientId" type="java.lang.String"--%>
<%--@elvariable id="frontendLibraryVersion" type="de.is24.search.expose.FrontendLibraryVersion"--%>

<page:popup headline="Angebot weiterleiten: ${expose.title}" staticHost="${staticHost}"
            frontendLibraryVersion="${frontendLibraryVersion}">
  <springtags:bind path="sendAfriendForm.*">

    <c:if test="${status.error}">
      <div class="status-message status-error margin-bottom-m">
        <h4>
          <c:choose>
            <c:when test='${fn:contains( fn:join(status.errorCodes, ""), "emailSendfailed")}'>
              Es ist ein Fehler aufgetreten. Die E-Mail wurde nicht versendet.
            </c:when>
            <c:otherwise>
              Bitte korrigieren Sie die rot markierten Felder!<br/>
            </c:otherwise>
          </c:choose>
          <c:forEach items="${status.errorCodes}" var="error">
            <c:if test="${error eq 'senderEmail.invalid'}">
              Die Absender E-Mail-Adresse ist nicht korrekt.<br/>
            </c:if>
            <c:if test="${error eq 'recipientEmail.invalid'}">
              Die Empfänger E-Mail-Adresse ist nicht korrekt.<br/>
            </c:if>
          </c:forEach>
        </h4>
      </div>
    </c:if>
  </springtags:bind>

  <div class="margin-bottom-l">
    <p><c:out value="${expose.location.asStringWithAddressAndGeoHierarchy}"/></p>
  </div>

  <form:form action="/expose/sendAFriend.go" commandName="sendAfriendForm" method="post"
             cssClass="form form-theme-standard" accept-charset="ISO-8859-1 UTF-8">
    <input name="id" type="hidden" value="${expose.id}"/>
    <input name="client-id" type="hidden" value="<c:out value="${clientId}"/>"/>

    <h3>Bitte ergänzen Sie die folgenden Informationen</h3>

    <springtags:bind path="recipientName">
      <div class="grid margin-bottom-s">
        <label class="required grid-item palm-one-whole" for="rec-name">Empfänger Name: </label>
        <form:input path="recipientName" cssClass="input-text grid-item ${status.error ? 'error' : ''}" id="rec-name"
                    maxlength="100"/>
      </div>
    </springtags:bind>
    <springtags:bind path="recipientEmail">
      <div class="grid margin-bottom-s">
        <label class="required grid-item" for="rec-mail">Empfänger E-Mail: </label>
        <form:input path="recipientEmail" cssClass="input-text grid-item ${status.error ? 'error' : ''}" id="rec-mail"
                    maxlength="150"/>
      </div>
    </springtags:bind>
    <springtags:bind path="senderName">
      <div class="grid margin-bottom-s">
        <label class="required grid-item" for="sender-name">Absender Name: </label>
        <form:input path="senderName" cssClass="input-text grid-item ${status.error ? 'error' : ''}" id="sender-name"
                    maxlength="100"/>
      </div>
    </springtags:bind>
    <springtags:bind path="senderEmail">
      <div class="grid margin-bottom-s">
        <label class="required grid-item" for="sender-mail">Absender E-Mail: </label>
        <form:input path="senderEmail" cssClass="input-text grid-item ${status.error ? 'error' : ''}" id="sender-mail"
                    maxlength="150"/>
      </div>
    </springtags:bind>


    <p class="fineprint margin-left-xs">Mit einem <span class="font-brandorange">*</span> gekennzeichnete Felder sind
      Pflichtfelder.</p>
    <div class="align-right margin-bottom-xs">
      <input class="button-primary" type="submit" value="Absenden"/>
    </div>

  </form:form>
</page:popup>

