<%@ tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ tag description="This tag renders a One-step Search Form." %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.is24.de/expose-core" prefix="e" %>
<%@ taglib uri="http://www.is24.de/ceule/featureswitches" prefix="feature" %>

<c:set var="ossID" value="oss-form" />

<form id="${ossID}" class="oss-form form" data-qa="oss-form">
  <div class="grid grid-flex gutter-vertical-m">
    <div class="grid-item palm-one-whole lap-five-sixths desk-five-sixths">
      <%-- Primary Criteria - start --%>
      <div class="oss-main-criteria grid grid-flex gutter-vertical-m">
        <div class="grid-item palm-one-whole lap-two-twelfths desk-two-twelfths">
          <ul class="oss-marketing-type-toggle margin-bottom-s <c:if test="${feature:isActive('HISTORICAL_LISTINGS_ENABLED')}"> historical </c:if>">
            <li>
              <input id="oss-marketing-type-toggle-rent" type="radio" name="oss-marketing-type-toggle" value="RENT" checked/>
              <label for="oss-marketing-type-toggle-rent">Mieten</label>
            </li><%-- eat up whitespace
            --%><li>
              <input id="oss-marketing-type-toggle-buy" type="radio" name="oss-marketing-type-toggle" value="BUY" />
              <label for="oss-marketing-type-toggle-buy">Kaufen</label>
            </li><%-- eat up whitespace
            --%><li>
              <input id="oss-marketing-type-toggle-rent-historical" type="radio" name="oss-marketing-type-toggle" value="RENT_HISTORICAL" />
              <label for="oss-marketing-type-toggle-rent-historical">Archiv-Miete</label>
            </li><%-- eat up whitespace
            --%><li>
              <input id="oss-marketing-type-toggle-buy-historical" type="radio" name="oss-marketing-type-toggle" value="BUY_HISTORICAL" />
              <label for="oss-marketing-type-toggle-buy-historical">Archiv-Kauf</label>
            </li>
          </ul>
          <select name="marketingType" tabindex="1" class="oss-main-criterion select pretty-select" data-value="">
            <option value="RENT">Mieten</option>
            <option value="BUY">Kaufen</option>
            <option value="RENT_HISTORICAL">Archiv-Miete</option>
            <option value="BUY_HISTORICAL">Archiv-Kauf</option>
          </select><%-- eat up whitespace
          --%><span class="pretty-select-icon"></span>
        </div>
        <div class="grid-item palm-one-whole lap-seven-twelfths desk-seven-twelfths">
          <div class="oss-location-container absolute-reference">
            <input type="text" tabindex="2" placeholder="Wo: Ort, Stadt, Strasse, PLZ oder Scout-ID" autocomplete="off" class="oss-main-criterion oss-location oss-location--with-icons input-text no-mouseflow" />
            <span class="oss-current-location-button fa fa-location-arrow"></span>
            <span class="oss-clear-input-button fa fa-close"></span>
          </div>
        </div>
        <div class="grid-item palm-one-whole lap-three-twelfths desk-three-twelfths">
          <select tabindex="3" class="oss-main-criterion oss-real-estate-type select pretty-select" data-marketing-type="RENT" data-value="">
          </select><%-- eat up whitespace
          --%><span class="pretty-select-icon"></span>

          <select tabindex="3" class="oss-main-criterion oss-real-estate-type select pretty-select" data-marketing-type="BUY" data-value="" disabled>
          </select><%-- eat up whitespace
          --%><span class="pretty-select-icon"></span>

          <select tabindex="3" class="oss-main-criterion oss-real-estate-type select pretty-select" data-marketing-type="RENT_HISTORICAL" data-value="" disabled>
          </select><%-- eat up whitespace
          --%><span class="pretty-select-icon"></span>

          <select tabindex="3" class="oss-main-criterion oss-real-estate-type select pretty-select" data-marketing-type="BUY_HISTORICAL" data-value="" disabled>
          </select><%-- eat up whitespace
          --%><span class="pretty-select-icon"></span>
        </div>
      </div>
    </div>
    <%-- Primary Criteria - end --%>

    <%-- Submit Button - start --%>
    <div class="grid-item palm-one-whole lap-one-sixth desk-one-sixth palm-order-one-down">
      <button type="button" tabindex="9" class="oss-main-criterion oss-button oss-result-count-container button-primary one-whole">
        Suchen
      </button>
    </div>
    <%-- Submit Button - end --%>

    <%-- Bottom Line - start --%>
    <div class="grid-item one-whole">
      <div class="grid grid-flex gutter-s">
        <%-- Secondary Criteria - start --%>
        <div class="grid-item palm-one-whole lap-one-whole desk-one-whole">
          <h3 class="fineprint font-xs lap-hide desk-hide">Optional</h3>

          <div class="grid grid-flex grid-fill-rows gutter-m oss-secondary-criteria oss-secondary-criteria--centered">
            <div class="grid-item oss-price-area">
              <div class="label-wrapper">
                <input class="oss-price oss-secondary-criterion input-text" type="number" tabindex="4" placeholder="Preis bis" data-label="bis {{value}} €" />
              </div>
            </div>
            <div class="grid-item oss-begin-rent-area">
              <div class="label-wrapper">
                <input class="oss-begin-rent oss-secondary-criterion input-text" type="text" tabindex="5" placeholder="Bezugsfrei am" />
              </div>
            </div>

            <div class="grid-item oss-price-type-area">
              <select tabindex="5" class="oss-price-type oss-secondary-criterion select pretty-select" data-value="">
                <option value="">Miete pro</option>
                <option value="RENT_PER_MONTH_PRICE">pro Monat</option>
                <option value="RENT_PER_SQM_PRICE">pro m<sup>2</sup></option>
              </select><%-- eat up whitespace
              --%><span class="pretty-select-icon"></span>
            </div>

            <div class="grid-item oss-rooms-area">
              <select tabindex="6" class="oss-rooms oss-secondary-criterion select pretty-select" data-value="">
                <option value="">Zimmer egal</option>
                <option value="1">ab 1 Zimmer</option>
                <option value="1,5">ab 1,5 Zimmer</option>
                <option value="2">ab 2 Zimmer</option>
                <option value="2,5">ab 2,5 Zimmer</option>
                <option value="3">ab 3 Zimmer</option>
                <option value="3,5">ab 3,5 Zimmer</option>
                <option value="4">ab 4 Zimmer</option>
                <option value="5">ab 5 Zimmer</option>
              </select><%-- eat up whitespace
              --%><span class="pretty-select-icon"></span>
            </div>

            <div class="grid-item oss-area-area">
              <div class="label-wrapper">
                <input tabindex="7" type="number" placeholder="Fläche ab" class="oss-area oss-secondary-criterion input-text" data-label="ab {{value}} m<sup>2</sup>" data-value="" />
              </div>
            </div>

            <div class="grid-item oss-radius-and-travel-time-area">
              <select tabindex="8" class="oss-radius-and-travel-time oss-secondary-criterion select pretty-select" data-value="NONE">
                <option value="NONE" selected>Umkreis/Fahrzeit</option>
                <optgroup label="Umkreis" data-criterion="radius">
                  <option value="Km1">1 km</option>
                  <option value="Km2">2 km</option>
                  <option value="Km3">3 km</option>
                  <option value="Km4">4 km</option>
                  <option value="Km5">5 km</option>
                  <option value="Km10">10 km</option>
                  <option value="Km15">15 km</option>
                  <option value="Km20">20 km</option>
                  <option value="Km50">50 km</option>
                </optgroup>
                <optgroup label="Fahrzeit" data-criterion="travelTime">
                  <option value="Min10">10 min</option>
                  <option value="Min15">15 min</option>
                  <option value="Min20">20 min</option>
                  <option value="Min30">30 min</option>
                  <option value="Min45">45 min</option>
                  <option value="Min60">60 min</option>
                  <option value="Min90">90 min</option>
                </optgroup>
              </select><%-- eat up whitespace
              --%><span class="pretty-select-icon"></span>
            </div>

            <div class="grid-item oss-radius-area">
              <select tabindex="8" class="oss-radius oss-secondary-criterion select pretty-select" data-value="NONE">
                <option value="NONE" selected>Umkreis</option>
                <option value="Km1">1 km</option>
                <option value="Km2">2 km</option>
                <option value="Km3">3 km</option>
                <option value="Km4">4 km</option>
                <option value="Km5">5 km</option>
                <option value="Km10">10 km</option>
                <option value="Km15">15 km</option>
                <option value="Km20">20 km</option>
                <option value="Km50">50 km</option>
              </select><%-- eat up whitespace
              --%><span class="pretty-select-icon"></span>
            </div>

          </div>
        </div>
        <%-- Secondary Criteria - end --%>
      </div>
    </div>
    <%-- Bottom Line - end --%>
  </div>
</form>

<script>
  window.IS24 = window.IS24 || {};

  IS24.expose = IS24.expose || {};
  IS24.expose.oss = IS24.expose.oss || {};

  IS24.expose.oss.id = "${ossID}";
</script>
