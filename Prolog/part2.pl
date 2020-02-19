distance(istanbul, rize, 968).
distance(istanbul, van, 1262).
distance(istanbul, ankara, 352).
distance(istanbul, gaziantep, 847).
distance(istanbul, antalya, 483).
distance(istanbul, izmir, 329).
distance(rize, van, 373).
distance(van, ankara, 920).
distance(ankara, konya, 227).
distance(konya, antalya, 192).
distance(gaziantep, antalya, 592).
distance(izmir, isparta, 309).
distance(isparta, burdur, 25).
distance(edirne, edremit, 244).
distance(edremit, erzincan, 1027).
distance(rize, istanbul, 968).
distance(van, istanbul, 1262).
distance(ankara, istanbul, 352).
distance(gaziantep, istanbul, 847).
distance(antalya, istanbul, 483).
distance(izmir, istanbul, 329).
distance(van, rize, 373).
distance(ankara, van, 920).
distance(konya, ankara, 227).
distance(antalya, konya, 192).
distance(antalya, gaziantep, 592).
distance(isparta, izmir, 309).
distance(burdur, isparta, 25).
distance(edremit, edirne, 244).
distance(erzincan, edremit, 1027).


% If there is a flight between X and Y.
route(X,Y,C) :- distance(X,Y,C). 
% A list of vectexes.
route(X , Y , C) :- sroute(X , Y , C , []). 
%L (Vertex list) list X (city) "Is there?" ,"is not there?" flight fact is invoked.
% It is then  called with [X] + L as recursively and the flight cost is calculated.
sroute(X , Y , C , _) :- distance(X , Y , C).
sroute(X , Y , C , L) :- \+ member(X , L), distance(X , Z , A), 					
							sroute(Z , Y , B , [X|L]), X\=Y, C is A + B.	
