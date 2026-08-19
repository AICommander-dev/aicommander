# Jak opublikować serwer MCP w OpenAI/Codex i Cursor

Ten poradnik opisuje dwa niezależne kanały publikacji:

1. **OpenAI Plugins Directory** — jeden wspólny katalog dla ChatGPT i Codexa.
   Nie składa się osobnego zgłoszenia „do OpenAI” i drugiego „do Codexa”.
2. **Cursor Marketplace** — osobny katalog Anysphere, z osobnym manifestem,
   repozytorium i procesem recenzji.

Instrukcja zakłada serwer MCP dostępny przez Streamable HTTP. Plugin lokalny
uruchamiany przez stdio może być wygodny do prywatnego użycia, ale zgłoszenie
publiczne OpenAI wymaga publicznego, produkcyjnego adresu MCP.

## 1. Wspólne przygotowanie serwera MCP

Przed rozpoczęciem któregokolwiek zgłoszenia:

- udostępnij stabilny endpoint HTTPS, np. `https://example.com/mcp`;
- zaimplementuj `initialize`, `tools/list` i `tools/call` zgodnie z MCP;
- dodaj każdemu narzędziu czytelny `title` oraz prawdziwe anotacje:
  `readOnlyHint`, `destructiveHint` i `openWorldHint`;
- jasno opisz skutki uboczne i wymagane potwierdzenia w opisach narzędzi;
- jeżeli serwer wymaga konta, skonfiguruj OAuth 2.1, PKCE S256, Protected
  Resource Metadata i Authorization Server Metadata;
- obsłuż parametr OAuth `resource` na etapach authorize i token oraz weryfikuj
  audience, zakresy i wygaśnięcie tokenu przy każdym wywołaniu;
- opublikuj regulamin, politykę prywatności i działający kontakt supportu;
- przygotuj odizolowane konto oraz dane testowe dla recenzenta;
- przetestuj całość na produkcji, a nie wyłącznie na localhost.

Nigdy nie umieszczaj tokenów, haseł recenzenta ani prywatnych identyfikatorów
zasobów w publicznym repozytorium.

## 2. Publikacja w OpenAI Plugins Directory

Dokumentacja:

- <https://developers.openai.com/plugins/build/plugins>
- <https://developers.openai.com/plugins/build/auth>
- <https://developers.openai.com/plugins/deploy/submission>
- <https://developers.openai.com/plugins/deploy/app-review>

### Wymagania organizacyjne

1. Użyj organizacji i projektu OpenAI Platform z global data residency.
2. Zweryfikuj tożsamość dewelopera albo firmy w tej organizacji.
3. Upewnij się, że osoba składająca zgłoszenie ma uprawnienie
   **Apps Management: Write**.
4. Przygotuj publiczny, produkcyjny URL MCP.

### Pakiet pluginu

Minimalny pakiet Codex ma manifest:

```text
my-plugin/
├── .codex-plugin/
│   └── plugin.json
├── .mcp.json
├── assets/
│   └── icon.png
└── README.md
```

Manifest opisuje nazwę, wydawcę, kategorię, politykę prywatności, regulamin,
logo i starter prompts. `.mcp.json` opisuje serwer używany przez lokalny Codex.
Publiczny formularz niezależnie skanuje produkcyjny endpoint HTTP.

### Formularz zgłoszenia

1. Otwórz portal publikacji pluginów w OpenAI Platform.
2. Wybierz wariant **With MCP** dla pluginu wyłącznie MCP.
3. Podaj produkcyjny URL serwera i uruchom **Scan Tools**.
4. Sprawdź zaimportowane nazwy, opisy, schematy i anotacje wszystkich narzędzi.
5. Dodaj maksymalnie trzy krótkie starter prompts pokazujące realne zastosowania.
6. Dodaj co najmniej pięć pozytywnych test cases. Każdy powinien zawierać
   prompt, potrzebny fixture i oczekiwane zachowanie/narzędzie.
7. Dodaj co najmniej trzy negatywne test cases, np. próbę działania bez
   uprawnień, destrukcyjne żądanie bez potwierdzenia i nieistniejący zasób.
8. Podaj release notes, kraje dostępności, support, politykę prywatności i
   regulamin.
9. Jeśli portal wymaga weryfikacji domeny, umieść wygenerowany token dokładnie
   pod `https://<host>/.well-known/openai-apps-challenge`.
10. Podaj dane konta recenzenta. Logowanie nie może wymagać dostępu do Twojej
    skrzynki, kodu SMS, MFA ani dodatkowej weryfikacji e-mail.
11. Uruchom ponownie wszystkie test cases na produkcji i wyślij zgłoszenie.

### OAuth dla OpenAI

OpenAI przekazuje `resource` zarówno do authorize, jak i token endpointu.
Serwer autoryzacyjny powinien związać token z tym zasobem, a MCP odrzucać token
o złym audience lub scope. Dla ograniczeń domenowych Enterprise należy również
obsłużyć `openid`, `email` i UserInfo zwracające zweryfikowany adres e-mail.

## 3. Publikacja w Cursor Marketplace

Dokumentacja i wzorce:

- <https://cursor.com/docs/plugins>
- <https://cursor.com/docs/mcp>
- <https://github.com/cursor/plugin-template>
- <https://cursor.com/marketplace/publish>

### Publiczne repozytorium pluginu

Cursor wymaga publicznego, otwartego repozytorium zawierającego komponenty
pluginu. Nie oznacza to obowiązku publikacji całego backendu SaaS. Dla zdalnego
MCP otwarte mogą być manifest, konfiguracja i dokumentacja pluginu, podczas gdy
hostowana implementacja pozostaje usługą zamkniętą.

Minimalny plugin pojedynczy:

```text
my-plugin/
├── .cursor-plugin/
│   └── plugin.json
├── mcp.json
├── assets/
│   └── logo.png
├── README.md
└── LICENSE
```

Przykładowy `mcp.json` dla zdalnego serwera:

```json
{
  "mcpServers": {
    "my-server": {
      "type": "http",
      "url": "https://example.com/mcp"
    }
  }
}
```

### Test lokalny

1. Umieść repozytorium pod
   `~/.cursor/plugins/local/<plugin-name>`.
2. Uruchom w Cursor **Developer: Reload Window**.
3. Sprawdź **Settings → Plugins → Installed**.
4. Połącz MCP i przeprowadź OAuth z czystej sesji.
5. Przetestuj przynajmniej operację odczytu oraz kontrolowaną operację zapisu.
6. Zweryfikuj, że Cursor pokazuje potwierdzenia dla operacji destrukcyjnych.

### OAuth Cursor

W trakcie migracji Cursor może używać jednego z trzech callbacków:

```text
https://www.cursor.com/agents/mcp/oauth/callback
http://localhost:8787/callback
cursor://anysphere.cursor-mcp/oauth/callback
```

Jeżeli wspierasz stary custom scheme, dodaj wyłącznie powyższy dokładny URI do
allowlisty. Nie akceptuj dowolnych `cursor://` ani dowolnych custom schemes.

### Zgłoszenie

1. Umieść plugin na domyślnej gałęzi publicznego repozytorium.
2. Sprawdź, czy README opisuje wymagane konto, płatne funkcje, ryzyka,
   prywatność i support.
3. Otwórz <https://cursor.com/marketplace/publish> po zalogowaniu do Cursor.
4. Podaj URL repozytorium i uruchom skanowanie.
5. Uzupełnij opis, kategorię, dane wydawcy i instrukcję testową.
6. Wyślij zgłoszenie do ręcznej recenzji Anysphere.

## 4. AI Commander — konkretne pliki i adresy

OpenAI/Codex package:

```text
plugins/aicommander/.codex-plugin/plugin.json
plugins/aicommander/.mcp.json
plugins/aicommander/SUBMISSION.md
```

Cursor package w publicznym repo:

```text
.cursor-plugin/plugin.json
mcp.json
CURSOR-MARKETPLACE.md
```

Produkcja:

```text
MCP:     https://aicommander.dev/mcp
Docs:    https://aicommander.dev/docs/
Privacy: https://aicommander.dev/privacy/
Support: support@coderai.dev
```

Przed wysłaniem któregokolwiek zgłoszenia trzeba wdrożyć aktualne anotacje
narzędzi i obsługę callbacków OAuth, a następnie przejść pełny scenariusz
recenzenta na odizolowanej maszynie testowej.

Na dziś pakiet Cursor może zostać zgłoszony po wdrożeniu i teście OAuth.
Zgłoszenie OpenAI/Codex wymaga jeszcze domknięcia wiązania OAuth `resource` z
audience tokenu, obsługi `openid`/`email` i UserInfo oraz przygotowania konta
recenzenta niewymagającego kodu e-mail, SMS ani MFA. Wymagania organizacyjne,
token domenowy i dane recenzenta uzupełnia się dopiero w portalu OpenAI; nie
należy publikować ich w repozytorium.
