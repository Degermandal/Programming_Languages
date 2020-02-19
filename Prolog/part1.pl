% I wrote my flights as bidirectional.
% first direction
flight(istanbul, rize).
flight(istanbul, van).
flight(istanbul, ankara).
flight(istanbul, gaziantep).
flight(istanbul, antalya).
flight(istanbul, izmir).
flight(rize, van).
flight(van, ankara).
flight(ankara, konya).
flight(konya, antalya).
flight(gaziantep, antalya).
flight(izmir, isparta).
flight(isparta, burdur).
flight(edirne, edremit).
flight(edremit, erzincan).

% second direction
flight(rize, istanbul).
flight(van, istanbul).
flight(ankara, istanbul).
flight(gaziantep, istanbul).
flight(antalya, istanbul).
flight(izmir, istanbul).
flight(van, rize).
flight(ankara, van).
flight(konya, ankara).
flight(antalya, konya).
flight(antalya, gaziantep).
flight(isparta, izmir).
flight(burdur, isparta).
flight(edremit, edirne).
flight(erzincan, edremit).

%  Predicate that defines a route between any two adjacent points and use recursion
routeNoCycle(X, Y, _) :- flight(X, Y).
%routeNoCycle(X, Y, _) :- flight(Y, X).
routeNoCycle(X, Z, PathSoFar) :- 
flight(X, Y), \+ member(Y, PathSoFar), routeNoCycle(Y, Z, [Y|PathSoFar]), Z \= X.
route(X, Y):- routeNoCycle(X, Y, []).








