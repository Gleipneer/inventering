# Arbetssätt enligt Scrum

Vi arbetar i fyra korta sprintar. Varje sprint ska leda till något som går att testa eller visa upp.

Vi använder GitHub Project Board för att hålla reda på arbetet. Alla uppgifter läggs in som User Stories. När någon börjar arbeta med en uppgift flyttas den till `In Progress`. När uppgiften är klar och testad flyttas den till `Done`.

## Roller

**Product Owner** ansvarar för produktens mål och bestämmer vad som är viktigast att göra först.

**Scrum Master** ansvarar för att arbetssättet följs och skriver ner vad gruppen kommer fram till efter varje sprint.

**Utvecklare** ansvarar för att skriva, testa och dokumentera scriptet.

# Product Backlog

## Sprint 1 – Projektstart och basscript

* Som grupp vill vi dokumentera en Product Vision så att alla förstår produktens mål och avgränsningar.
* Som grupp vill vi ha ett GitHub-repo och en fungerande Project Board så att arbetet kan följas enligt Scrum.
* Som systemadministratör vill jag ha ett körbart PowerShell-basscript som skapar en loggfil så att vi kan verifiera att grunden fungerar.

**Resultat efter sprinten:** Vi har en tydlig plan, en GitHub-tavla och ett enkelt script som kan skapa en loggfil.

## Sprint 2 – Inventering med CIM/WMI

* Som systemadministratör vill jag att scriptet ska kunna inventera minst en dator med CIM/WMI så att vi kan hämta systeminformation.
* Som systemadministratör vill jag att inventeringsresultatet ska sparas i en loggfil så att vi kan kontrollera och visa vad scriptet hittar.

**Resultat efter sprinten:** Scriptet kan läsa information från minst en dator och spara resultatet i en loggfil.

## Sprint 3 – Klienter, servrar och säker testning

* Som miljöansvarig vill jag att scriptet ska kunna skilja klientdatorer från servrar så att viktiga maskiner inte stängs av.
* Som miljöansvarig vill jag att scriptet ska kunna identifiera inaktiva klienter så att vi kan hitta datorer som inte behöver vara igång.
* Som utvecklare vill jag testa avstängningsfunktionen i ett säkert testläge så att ingen fel dator stängs av.

**Resultat efter sprinten:** Scriptet kan skilja på klienter och servrar och visa vilka klienter som skulle kunna stängas av.

## Sprint 4 – Automatisk körning och redovisning

* Som systemadministratör vill jag schemalägga scriptet klockan 20:00 så att lösningen kan köras automatiskt.
* Som grupp vill vi testa och dokumentera hela lösningen så att den går att visa upp vid redovisningen.

**Resultat efter sprinten:** Vi har en testad och dokumenterad lösning som kan demonstreras.

# Sprint Review och Retrospective

Efter varje sprint visar gruppen vad som fungerar. Det kan till exempel vara en loggfil, ett inventeringsresultat eller en testad funktion.

Efter detta pratar gruppen om:

* Vad gick bra?
* Vad gick mindre bra?
* Vad behöver vi förbättra till nästa sprint?

Scrum Master skriver ner det viktigaste från genomgången.

# Definition of Done

En User Story är klar när:

* uppgiften är genomförd,
* funktionen är testad,
* resultatet går att visa upp,
* GitHub-tavlan är uppdaterad.

Scriptet får endast stänga av en godkänd testklient. Servrar ska aldrig kunna stängas av av scriptet.
