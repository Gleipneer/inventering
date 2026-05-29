# Arbetssätt enligt Scrum

Vi arbetar i korta sprintar där varje sprint ska leda till något som går att testa eller visa upp. Arbetet planeras och följs upp i GitHub Project Board.

Varje uppgift ska finnas som en User Story på tavlan. När någon börjar arbeta med en uppgift flyttas den till `In Progress`. När uppgiften är testad och klar flyttas den till `Done`.

## Roller

**Product Owner** ansvarar för produktens mål och prioriterar vad som är viktigast att bygga.

**Scrum Master** ansvarar för att gruppen följer arbetssättet och dokumenterar Sprint Review och Sprint Retrospective.

**Utvecklare** ansvarar för att skriva, testa och dokumentera scriptet.

# Product Backlog

## Sprint 0 – Projektstart och struktur

- Som grupp vill vi skapa GitHub-repo och Project Board så att vi kan planera och följa arbetet.
- Som grupp vill vi bestämma roller och skapa produktvision, roadmap och backlog så att projektet får en tydlig riktning.
- Som utvecklare vill vi skapa ett enkelt basscript med loggning så att vi har en fungerande grund.

## Sprint 1 – Inventering med CIM/WMI

- Som systemadministratör vill jag att scriptet ska kunna inventera minst en dator med CIM/WMI så att vi kan hämta systeminformation.
- Som systemadministratör vill jag att resultatet ska skrivas till en loggfil så att vi kan kontrollera och visa vad scriptet hittar.

## Sprint 2 – Klienter, servrar och inaktiva maskiner

- Som miljöansvarig vill jag att scriptet ska kunna skilja klienter från servrar så att viktiga maskiner inte stängs av.
- Som miljöansvarig vill jag att scriptet ska kunna hitta inaktiva klienter så att vi kan identifiera möjliga energibesparingar.
- Som utvecklare vill jag först testa avstängningslogiken i simulerat läge så att ingen fel maskin påverkas.

## Sprint 3 – Automatisering och redovisning

- Som systemadministratör vill jag schemalägga scriptet klockan 20:00 så att lösningen kan köras automatiskt.
- Som grupp vill vi testa och dokumentera hela lösningen så att den går att visa upp vid redovisningen.

# Sprint Review och Retrospective

Efter varje sprint visar gruppen vad som fungerar. Det kan vara ett körbart script, en loggfil eller ett testresultat.

Efter demonstrationen diskuterar gruppen vad som fungerade bra, vad som behöver förbättras och vad som ska ändras till nästa sprint. Scrum Master dokumenterar detta.

# Definition of Done

En uppgift räknas som klar när:

- den är genomförd,
- den är testad,
- resultatet går att visa upp,
- GitHub-tavlan är uppdaterad.

Avstängning får endast testas på en godkänd klientdator. Servrar ska aldrig kunna stängas av av scriptet.