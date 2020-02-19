% Helper function
less(X, Y) :- var(X); var(Y).
less(X, Y) :- nonvar(X), nonvar(Y), X<Y.
	
%4.1. Define a Prolog predicate “element(E,S)” that returns true if E is in S.
% element(E,S) succeeds when an element E is element set S.
element([], _) :- fail.
element(X, []) :- fail.
element(X, [X|Y]).
element(X, [Z|Y]) :- element(X, Y).

%4.2. Define a Prolog predicate “union(S1,S2,S3)” that returns true if S3 is the union of S1 and S2.
% union(A,B,R) where R is the union of sets A and B. That is, R contains elements that are element either A or B.

% empty set
union([], S, S).
union(S, [], S) :- S \= [].

% H1 = H2
union([H1|T1], [H1|T2], [H1|T3]) :-
   union(T1, T2, T3).

% H1 \= H2
union([H1|T1], [H2|T2], [H1|T3]) :-
   less(H1, H2), union(T1, [H2|T2], T3).

union([H1|T1], [H2|T2], [H2|T3]) :-
   less(H2, H1), union([H1|T1], T2, T3).
 
%4.3. Define a Prolog predicate “intersect(S1,S2,S3)” that returns true if S3 is the intersection of of S1 and S2.
% intersection(A,B,R) where R is the intersection of sets A and B. R contains elements that are both element A and B.  

% empty set 
intersect([], _, []).
intersect(_, [], []).

% X element S
intersect([X|Y], S, [X|Z]) :-
    element(X, S), intersect(Y, S, Z).

% X not element S
intersect([X|Y], [Z|A], B) :-
   less(X, Z), intersect(Y, [Z|A], B).

intersect([X|Y], [Z|A], B) :-
   less(Z, X), intersect([X|Y], A, B).


%4.3. Define a Prolog predicate “equivalent(S1,S2)” that returns true if S1 and S2 are equivalent sets.
% I find firstly subsets then I found equivalent
% empty set
subset([], L).
% H1 = H2
subset([H1|T1], [H1|T2]) :- subset(T1, T2).

% H1 \= H2
subset([H1|T1], [H2|T2]) :- less(H2, H1),subset([H1|T1], T2).

equivalent(X,Y) :- subset(X, Y), subset(Y, X).

