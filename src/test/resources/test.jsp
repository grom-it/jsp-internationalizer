<%@ page session="false" pageEncoding="UTF-8" %>
<attributes:attributesLayout>
  <jsp:attribute>
    <attributes:priceAttribute label="Kaltmiete" price="${baseRent}"/>
    <attributes:numberAttribute label="Zi." value="${noRooms}" pattern="#,##0.00;-#,##0.00"/>
    <attributes:numberAttribute label="Fläche" value="${livingSpace}" pattern="#,##0.00;-#,##0.00"/>
  </jsp:attribute>
</attributes:attributesLayout>

<form:form action="/action.go" method="post" accept-charset="ISO-8859-1 UTF-8">
    <h3>Bitte ergänzen Sie die folgenden Informationen</h3>

    <div>
        <label for="rec-name">Empfänger Name: </label>
        <form:input path="recipientName" maxlength="100" id="rec-name"/>
    </div>
    <div>
        <label class="required grid-item" for="rec-mail">Empfänger E-Mail: </label>
        <form:input path="recipientEmail" maxlength="150" id="rec-mail"/>
    </div>
    <div>
        <label class="required grid-item" for="sender-name">Absender Name: </label>
        <form:input path="senderName" maxlength="100" id="sender-name"/>
    </div>
    <div>
        <label class="required grid-item" for="sender-mail">Absender E-Mail: </label>
        <form:input path="senderEmail" maxlength="150" id="sender-mail"/>
    </div>


    <p>Mit einem <span class="orange">*</span> gekennzeichnete Felder sind Pflichtfelder.</p>
    <div>
        <input type="submit" value="Absenden"/>
    </div>
</form:form>
