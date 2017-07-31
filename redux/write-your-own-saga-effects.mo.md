# [MO] Write your own saga effects *(~3 min)*

## Owner: Alexandre Moureaux

## Prerequisites
- [ ] Redux installed
- [ ] Redux saga installed

## Reproducible example *(~3min)*

```javascript
// Create the CUSTOM EFFECT authenticatedCall somewhere
export function* makeAuthenticatedCall(apiCall: any): SagaType {
  const token = yield select(getAuthenticationToken);
  const response = yield call(() => Api.addAuthorizationHeader(apiCall, token));

  return response.body;
}

export function authenticatedCall(apiCall: any): SagaType {
  return call(makeAuthenticatedCall, apiCall);
}
// ----


// In your Saga, call it
export function* fetchFavoriteCinemas(): SagaType {
  yield authenticatedCall(
    Api.fetchFavoriteCinemas(),
  );
}
```
