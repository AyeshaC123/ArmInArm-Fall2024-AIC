# Use Case Description

**Use case**: Select Language

**Primary actor**: Client

**Goal in context**: To display the registration form in the language the client selects.

**Preconditions**: Translation is available for the language the client selects.

**Trigger**: Client clicks on an available language on the registration form.

**Scenario**:
- Client navigates to the registration form.
- Client clicks on a language listed at the top of the registration form UI.
- Registration form is translated to the selected language.
- Translated form is displayed to the client.

**Exceptions**:
- Client is not on the registration form page: Client navigates to the registration form.
- Client selects the language that is already being displayed: Client selects a different language, if the client needs the form to be translated.

**Priority**: High. Many clients cannot read English.


**Open issues**:
- Should languages other than Spanish and Creole be supported?
- Should translation be supported for pages other than the registration form?
