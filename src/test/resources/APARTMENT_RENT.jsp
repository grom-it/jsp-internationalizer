<%@ page session="false" pageEncoding="UTF-8" %>
<%@ page info="Renders the criterias and descriptions for the real estate type 'apartment rent'." %>

<%@ taglib tagdir="/WEB-INF/tags/expose/core/attributes" prefix="attributes" %>
<%@ taglib tagdir="/WEB-INF/tags/expose/core" prefix="expose" %>
<%@ taglib tagdir="/WEB-INF/tags/expose/core/similarObjects" prefix="similarObjects" %>
<%@ taglib tagdir="/WEB-INF/tags/expose/core/mediaAvailability" prefix="mediaAvailability" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.is24.de/expose-core" prefix="e" %>
<%@ taglib uri="http://www.is24.de/next-tags-is24" prefix="next" %>

<%--@elvariable id="expose" type="de.is24.search.expose.domain.ApartmentRentExpose"--%>
<%--@elvariable id="links" type="de.is24.search.expose.web.links.ExposeLinks"--%>
<%--@elvariable id="isPrintView" type="boolean"--%>
<%--@elvariable id="isServicesCarouselDisabled" type="java.lang.Boolean"--%>

<attributes:attributesLayout expose="${expose}">
  <jsp:attribute name="mainCriteria">
    <attributes:priceAttribute label="Kaltmiete" price="${expose.baseRent}" isMainCriteria="true"/>
    <attributes:numberAttribute label="Zi." value="${expose.noRooms}" pattern="#,##0.00;-#,##0.00" isMainCriteria="true"/>
    <attributes:numberAttribute label="Fläche" value="${expose.livingSpace}" postfix=" m²" pattern="#,##0.00;-#,##0.00" isMainCriteria="true"/>
  </jsp:attribute>

  <jsp:attribute name="booleanCriteria">
      <attributes:booleanAttribute label="Balkon/ Terrasse" value="${expose.balcony}"/>
      <attributes:booleanAttribute label="Keller" value="${expose.cellar}"/>
      <attributes:booleanAttribute label="Personenaufzug" value="${expose.lift}"/>
      <attributes:booleanAttribute label="Einbauküche" value="${expose.builtInKitchen}"/>
      <attributes:booleanAttribute label="Garten/ -mitbenutzung" value="${expose.garden}"/>
      <attributes:booleanAttribute label="Gäste-WC" value="${expose.guestToilet}"/>
      <attributes:booleanAttribute label="Stufenloser Zugang" value="${expose.handicappedAccessible}"/>
      <attributes:booleanAttribute label="Seniorengerechtes Wohnen" value="${expose.assistedLiving}"/>
      <attributes:booleanAttribute label="Wohnberechtigungsschein erforderlich" value="${expose.certificateOfEligibilityNeeded}"/>
      <attributes:booleanAttribute label="WG-geeignet" value="${expose.flatShareSuitable}"/>
  </jsp:attribute>

  <jsp:attribute name="details">
    <attributes:groupSeparator classes="criteria-group--two-columns">
      <attributes:enumAttribute label="Typ" value="${expose.apartmentType}"/>
      <attributes:simpleAttribute label="Etage" value="${expose.floor}" secondValue="${expose.noFloors}" combine="von"/>
      <attributes:numberAttribute label="Wohnfläche ca." value="${expose.livingSpace}" postfix=" m²" pattern="#,##0.00;-#,##0.00"/>
      <attributes:numberAttribute label="Nutzfläche ca." value="${expose.usableArea}" postfix=" m²" pattern="#,##0.00;-#,##0.00"/>
      <attributes:simpleAttribute label="Bezugsfrei ab" value="${expose.freeFrom}"/>
      <attributes:solvencyCheckLinkAttribute solvencyCheckLinkStatus="${expose.solvencyCheckLinkStatus}"/>
      <attributes:numberAttribute label="Zimmer" value="${expose.noRooms}" pattern="#,##0.00;-#,##0.00"/>
      <attributes:simpleAttribute label="Schlafzimmer" value="${expose.noBedRooms}"/>
      <attributes:simpleAttribute label="Badezimmer" value="${expose.noBathRooms}"/>
      <attributes:enumAttribute label="Haustiere" value="${expose.petsAllowed}"/>
      <attributes:simpleAttribute label="Garage/ Stellplatz" value="${exposeParkingAttribute}"/>
      <mediaAvailability:mediaAvailabilityLinkAttribute />
    </attributes:groupSeparator>

    <mediaAvailability:mediaAvailabilitySpeedCheck />

    <expose:premiumStats realEstateType="RENT"/>

    <attributes:groupSeparator label="Kosten" borderBefore="${true}">
      <attributes:grid>
        <%-- total rent group --%>
        <attributes:gridItem classes="lap-one-half desk-one-half padding-right-s">
          <attributes:priceAttribute label="Kaltmiete" price="${expose.baseRent}">
            <c:if test="${expose.getLocation().getAddress().isFullAddress()}">
              <next:includeContent fragment="/content/campaigns/is24/expose/mietcheck/mietcheck1/_jcr_content/par.html"/>
            </c:if>
          </attributes:priceAttribute>
          <attributes:numberAttribute label="Nebenkosten" isCurrency="true" value="${expose.serviceCharge}" prefix="+" postfix="€" altvernativeText="keine Angabe"/>
          <attributes:heatingCostsAttribute label="Heizkosten" heatingCosts="${expose.heatingCosts}" isHeatingCostsInServiceCharge="${expose.heatingCostsInServiceCharge}" serviceCharge="${expose.serviceCharge}"/>
          <attributes:totalRentAttribute label="Gesamtmiete" isCurrency="true" value="${expose.calculatedTotalRent}" prefix="=" postfix="€ "/>
        </attributes:gridItem>
        <%-- additional costs group --%>
        <attributes:gridItem classes="lap-one-half desk-one-half padding-left-s">
          <attributes:depositLinkAttribute expose="${expose}" label="Kaution o. Genossenschafts&shy;anteile" value="${expose.deposit}" isPrintView="${isPrintView}"/>
          <attributes:numberAttribute label="Miete für Garage/Stellplatz" value="${expose.parkingSpacePrice}" postfix="€" pattern="#,##0.00;-#,##0.00"/>
          <attributes:removalCosts expose="${expose}" />
        </attributes:gridItem>
      </attributes:grid>
    </attributes:groupSeparator>

    <attributes:groupSeparator classes="padding-top-l">
      <expose:removalZipcodeLeadEntry/>
    </attributes:groupSeparator>

    <attributes:groupSeparator label="Bausubstanz & Energieausweis" classes="criteria-group--border criteria-group--two-columns criteria-group--spacing">
      <attributes:constructionYearAttribute label="Baujahr" value="${expose.constructionYear}" isConstructionYearUnknown="${expose.constructionYearUnknown}"/>
      <attributes:simpleAttribute label="Modernisierung/ Sanierung" prefix="zuletzt" value="${expose.lastRefurbishment}"/>
      <attributes:enumAttribute label="Objektzustand" value="${expose.condition}"/>
      <attributes:enumAttribute label="Ausstattung" qaLabel="Qualität der Ausstattung" value="${expose.interiorQuality}" valueSuffix=".EXP975"/>
      <attributes:enumAttribute label="Heizungsart" value="${expose.heatingType}"/>
      <attributes:multiSelectionEnumAttribute label="Wesentliche Energieträger" values="${expose.firingTypesAsArray}"/>
      <attributes:energyCertificate
        data="${expose.energyCertificateData}"
        buildingEnergyRatingType="${expose.buildingEnergyRatingType}"
        thermalCharacteristic="${expose.thermalCharacteristic}"
        energyConsumptionContainsWarmWater="${expose.energyConsumptionContainsWarmWater}" />
    </attributes:groupSeparator>

    <c:if test="${expose.energyCertificateChartSupported}">
      <attributes:energyCertificateChart data="${expose.energyCertificateData}"/>
    </c:if>


    <c:if test="${!isServicesCarouselDisabled}">
      <attributes:groupSeparator label="Services passend zur Wohnung" classes="collapsibleContainer one-whole margin-bottom">
        <attributes:servicesCarousel/>
      </attributes:groupSeparator>
    </c:if>

  </jsp:attribute>

  <jsp:attribute name="notes">
      <similarObjects:similarExposeObjects expose="${expose}" developerProjectUrl="${links.developerProjectInformationLink.url.forHref}"/>
      <attributes:longTextAttribute label="Objektbeschreibung" value="${expose.descriptionNote}" isPrintView="${isPrintView}"/>
      <attributes:longTextAttribute label="Ausstattung" value="${expose.furnishingNote}" isPrintView="${isPrintView}"/>
  </jsp:attribute>

  <jsp:attribute name="otherNotes">
      <attributes:longTextAttribute label="Lage" value="${expose.locationNote}" isPrintView="${isPrintView}"/>
      <attributes:longTextAttribute label="Sonstiges" value="${expose.otherNote}" isPrintView="${isPrintView}"/>
  </jsp:attribute>

  <jsp:attribute name="additionalInfo">
    <expose:tenantDocuments realEstateType="RENT" shouldRenderHeader="${expose.otherNote}" />
  </jsp:attribute>

</attributes:attributesLayout>

<mediaAvailability:mediaAvailabilityLayerAttribute expose="${expose}"/>
