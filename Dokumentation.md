# Dokumentation

---

## Måndag 1/6 — Sprint 1

**Morgonmöte:** 09:00  
**Slutmöte:** 15:00  
**Deltagare:** Aaren, Joakim, Martin

Att göra som inte redan ligger i product backlog:
- Länka till dokumentation för möten och flytande dokumentering i README.md

Första morgonmötet blev betydligt längre än planerat då strukturen för projektet inte var helt fastställd — åtminstone inte tillräckligt för att direkt kunna dela ut user stories till utvecklarna i sprint 1. Sakta men säkert benade vi ut user stories för sprint 1 och delade ut dessa till de som var närvarande. Tanken var att få stommen klar och därmed majoriteten av de stora delarna på plats efter dagens sprint.

---

### Sprint Review

**Demonstration**  
Aaren visade upp att hon skapat en loggfunktion som loggar informationen inventeringsmodulen spottar ur sig.

**Vad som blev gjort**  
Två moduler, main.ps1 och loggning.psm1 var på plats efter dagens sprint. Allt fick definition of done förutom modulen som sköter avstängning.

**Hinder**

- Alla gruppmedlemmar dök inte upp vilket försvårade en rättvis uppdelning av projektets delar.
- Aaren blev tilldelad en spike för att undersöka möjligheten att mocka ett nätverk för testning, men det visade sig vara för svårt. Möjligt att idén skrotas och att vi på egen hand skapar egna miljöer eller använder redan existerande.
- Vi hade ingen kodstandard på plats. Vilket nät vi kodar för, vilken syntax vi använder m.m.
- Viss förkunskap saknas för att underlätta projektgången — dels tekniskt men framförallt kopplat till arbetsmetoden.

---

### Sprint Retrospective

Kommunikationen och samarbetet fungerade utan problem för de som deltog under sprinten. Vi var överens om att allt fungerat bra från start till avslut.

Vi valde att använda Discord för kommunikation, både muntligt och via chatt. På sätt och vis upplevde vi det som positivt att inte vara full grupp då det underlättade tilldelningen av user stories. Där och då hade vi svårt att se hur vi skulle bena ut projektet ytterligare.

En förbättringspunkt som togs upp var att våra individuella kunskapsnivåer skulle kunna vara högre. Med det menas att vi möjligtvis hade kunnat få mer vägledning från lärarna kring hur man tacklar vissa problem som uppstår i den här typen av projekt.

---

## Tisdag 2/6 — Sprint 2

**Morgonmöte:** 09:00  
**Slutmöte:** 15:00  
**Deltagare:** Martin, Joakim (Aaren via chatt)

Målet med dagens sprint var att modulen för shutdown skulle nå definition of done så att sammankopplingen i main.ps1 kunde påbörjas. Om tid fanns skulle även dokumentationen börja flyttas från Google Drive till projektet i form av .md-filer.

---

### Sprint Review

Under dagens sprint fokuserades arbetet på att färdigställa modulen för hantering av avstängning, utan vilken sammankopplingen inte kunnat påbörjas. Modulen fungerar men inte utan viss handpåläggning i form av nätverkskonfigurering.

Viss osäkerhet fanns kring hur sammankopplingen i main.ps1 skulle gå till. På grund av statusen på avstängningsmodulen har projektet haltat något under dagen, men tidsplanen bedöms inte ha påverkats nämnvärt då det var den sista stora komponenten att bygga.

Komplettering krävs dock för ovan nämnda modul — framförallt filtrering i InactiveClients.psm1 och loggningen i ClientShutdown.psm1. Anledningen till att modulen tog tid att färdigställa var problem kopplade till rättigheter i Windows-miljön.

---

### Sprint Retrospective

Trots att det kom fram väldigt lite att lägga in i dagens sprint fanns de utvecklare som inte var tilldelade något tillgängliga på Discord. Ytterligare tidstjuvar har varit bristande erfarenhet av arbetsmetoden samt kunskaper kring att bygga den här typen av skript.

---

## Onsdag 3/6 — Sprint 3

**Morgonmöte:** 09:15  
**Slutmöte:** 16:00  
**Deltagare:** Martin, Joakim, Benjamin, Aaren

Dagens sprint blev något annorlunda då planerade lektioner tog upp delar av dagen. Arbetet med projektet påbörjades därför inte på allvar förrän ~12:30.

Målet för dagen:

- Få till kopplingen mellan modulerna
- Se till att InactiveClients filtrerar bort klienter där en användare är inloggad
- Se till att ClientShutdown loggar vad den gör
- Se till att majoriteten av dokumentationen är på plats och vid behov bara behöver finjusteras senare

---

### Sprint Review

Efter sprintens slut hade vi två fungerande versioner av skriptet, om än något ostabila.
Beroende på skript och miljö fick man olika resultat.
Majoriteten av gångerna var det inte skriptet som var problemet utan Windows.

---

### Sprint Retrospective

Att sista sprinten blev på plats i skolan var väldigt givande. Speciellt när målet var att koppla samman allt
och justera det som behövde justeras.
Kommunikationen inom gruppen var bra och det var smidigt att ta upp småsaker som behövde göras.
Vi fick några mergekonflikter, vissa större än andra, men inget som inte gick att lösa.
På gott och ont var det bra att de uppstod så vi fick dra lärdom av det.

Absolut såg vi för- och nackdelar med att jobba både på plats och remote. Till framtiden skulle man kunna
ta beslut om detta dagligen beroende på vad som ligger i pipen för nästkommande dag.