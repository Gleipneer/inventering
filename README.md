# Grön IT-policy

# Product Vision

Visionen är att skapa ett PowerShell-script som inventerar ett bestämt nätverk. Syftet är att minska onödig energiförbrukning genom att hitta klientdatorer som inte behöver vara igång och kunna stänga av dem efter arbetstid.

Scriptet ska använda CIM/WMI för att hämta information om datorerna i nätverket. Det ska kunna skilja mellan klientdatorer och servrar, eftersom servrar och andra viktiga maskiner inte får stängas av.

Tanken är att scriptet ska kontrollera datorer inom vårt definierade klientintervall. Om en klient bedöms som inaktiv ska scriptet kunna visa eller genomföra en avstängning på ett säkert sätt.

Lösningen ska först testas i simuleringsläge så att vi kan se vad scriptet skulle göra utan att råka stänga av fel dator. Den färdiga lösningen ska kunna schemaläggas så att den körs automatiskt klockan 20:00.

# Arbetssätt enligt Scrum

Vi arbetar i fyra korta sprintar. Varje sprint ska leda till något som går att testa eller visa upp.

Vi använder GitHub Project Board för att hålla reda på arbetet. Uppgifterna ligger som User Stories på tavlan. När en uppgift ska göras i en sprint ligger den i Sprint Backlog. När någon börjar arbeta med uppgiften flyttas den till In Progress. När uppgiften är färdig och testad flyttas den till Done.

# Roller

Product Owner ansvarar för produktens mål och bestämmer vad som är viktigast att göra först.

Scrum Master ansvarar för att arbetssättet följs och skriver ner vad gruppen kommer fram till efter Sprint Review och Retrospective.

Utvecklare ansvarar för att skriva, testa och dokumentera scriptet.

# Product Backlog

## Sprint 1 – Grund, inventering och loggning

I den första sprinten ska vi skapa grunden till lösningen. Vi ska börja bygga PowerShell-modulen och en startfil som kör scriptet. Scriptet ska även kunna inventera minst en dator med CIM/WMI och spara resultatet i en loggfil.

User Stories:

* Som utvecklare vill jag skapa en enkel PowerShell-modul och startfil med loggning så att vi har en fungerande grund att bygga vidare på.
* Som systemadministratör vill jag att scriptet ska kunna inventera minst en dator med CIM/WMI och spara resultatet i loggen så att vi kan visa att inventeringen fungerar.

Resultat efter sprinten:

Vi har en första fungerande version av modulen och startfilen. Scriptet kan läsa information från minst en dator och skriva resultatet till en loggfil.

## Sprint 2 – Klientintervall, servrar och inaktiva klienter

I den andra sprinten ska scriptet börja arbeta mot vårt definierade klientintervall i nätverket. Det ska kunna kontrollera flera datorer och skilja klientdatorer från servrar eller andra maskiner som inte får stängas av.

Scriptet ska också kunna markera vilka klienter som kan vara inaktiva och därför möjliga kandidater för avstängning.

User Stories:

* Som systemadministratör vill jag att scriptet ska söka igenom vårt definierade klientintervall så att flera datorer i nätverket kan kontrolleras.
* Som miljöansvarig vill jag att scriptet ska skilja klientdatorer från servrar och hoppa över skyddade maskiner så att viktiga datorer inte kan stängas av.
* Som miljöansvarig vill jag att scriptet ska identifiera inaktiva klientkandidater så att endast datorer som inte behöver vara igång föreslås för avstängning.

Resultat efter sprinten:

Scriptet kan kontrollera datorer inom klientintervallet, sortera bort servrar och visa vilka klienter som kan vara kandidater för avstängning.

## Sprint 3 – Avstängning och schemaläggning

I den tredje sprinten ska själva energiåtgärden göras färdig. Scriptet ska kunna testa avstängning i simuleringsläge och även kunna demonstreras på en godkänd testklient.

Vi ska också schemalägga scriptet så att det kan köras automatiskt klockan 20:00.

User Stories:

* Som utvecklare vill jag att avstängningen ska kunna testas i simuleringsläge och demonstreras kontrollerat på en godkänd testklient så att vi visar funktionen utan att riskera fel maskin.
* Som systemadministratör vill jag schemalägga scriptet till klockan 20:00 så att lösningen kan köras automatiskt utanför arbetstid.

Resultat efter sprinten:

Scriptets viktigaste funktioner är klara. Det kan inventera nätverket, logga resultat, skydda servrar, hitta möjliga inaktiva klienter och visa en säker avstängning. Det kan även schemaläggas till klockan 20:00.

## Sprint 4 – Kontroll och redovisning

Den fjärde sprinten sker samma dag som redovisningen. Därför ska vi inte bygga nya viktiga funktioner då. Lösningen ska redan vara klar efter Sprint 3.

I Sprint 4 ska vi kontrollera att allt fungerar, att dokumentationen finns och att vi kan visa upp lösningen på ett tydligt sätt.

User Stories:

* Som grupp vill vi testa hela flödet och genomföra en säker demonstration så att vi kan visa en fungerande produkt vid redovisningen.
* Som grupp vill vi slutkontrollera att lösningen och sprintresultaten är dokumenterade så att arbetet går att följa och bedöma.

Resultat efter sprinten:

Vi har kontrollerat att scriptet fungerar, att dokumentationen är klar och att gruppen kan genomföra redovisningen.

# Sprint Review och Retrospective

Efter varje sprint visar gruppen vad som fungerar. Det kan till exempel vara en loggfil, ett inventeringsresultat eller en testad funktion i scriptet.

Efter genomgången pratar gruppen om:

* Vad gick bra?
* Vad gick mindre bra?
* Vad behöver vi göra bättre till nästa sprint?

Scrum Master skriver ner det viktigaste efter varje sprint.

# Definition of Done

En User Story räknas som klar när:

* uppgiften är genomförd,
* funktionen är testad,
* resultatet går att visa upp,
* färdig kod är sparad i GitHub,
* GitHub-tavlan är uppdaterad.

Scriptet får endast genomföra avstängning på en godkänd testklient. Servrar och andra skyddade maskiner ska aldrig kunna stängas av av scriptet.
