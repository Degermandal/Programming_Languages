when(102, 10).
when(108, 12).
when(341, 14).
when(455, 16).
when(452, 17).

where(102, z23).
where(108, z11).
where(341, z06).
where(455, 207).
where(452, 207).

enroll(a, 102).
enroll(a, 108).
enroll(b, 102).
enroll(c, 108).
enroll(d, 341).
enroll(e, 455).

% 3.1
% I combine 3 three facts. Then I made a schedule with suitable data.
schedule(S, P, T) :- when(C, T), where(C, P), enroll(S,C).

% 3.2
% to need two facts: place and time. to combine the facts then made a predicate.
usage(X,Y) :- where(Z,X), when(Z, Y).

% 3.3
% I wrote helpConflicts because of needing three data: class, time and room. Then I combine them and I wrote a predicate.
% Then I checked for two things: time and room.
helpConflicts(T, C, R) :- when(C, T), where(C, R).
conflicts(X, Y) :- helpConflicts(T1, X, _), helpConflicts(T2, Y, _), T1 == T2.
conflicts(X, Y) :- helpConflicts(_, X, R1), helpConflicts(_, Y, R2), R1 == R2.


% 3.4
% I combined three facts and made a predicate. I combined 4 data: class, time, room and student.
% then I checked for meeting.
help(C, T, R, S) :- when(C,T), where(C, R), enroll(S, C).
meet(X, Y) :- help(_, T, R, X), help(_, T, R, Y).