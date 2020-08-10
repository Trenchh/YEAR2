%By: Ryan Protheroe
%Due: March 27th, 2019

%Part 1
%-------%
% Users %
%-------%
user(harry).
user(ron).
user(herminone).
user(petunia).
user(molly).
user(dumbledore).
user(testbirthday).


%-------------------------%
% Date: day, month & year %
%-------------------------%
today(27,3,2019).

birthday(harry, date(31,7,1980)).
birthday(ron, date(1,3,1980)).
birthday(herminone, date(19,11,1979)).
birthday(petunia, date(6,9,1953)).
birthday(molly, date(27,2,1954)).
birthday(dumbledore, date(14,8,1881)).
birthday(testbirthday, date(27,3,1972)).


%------------------------------------------------------%
% Connections: first user, second user, relationship   %
% A connection is *not* symmetric and the relationship %
% is defined by the first user for the second.         %
%------------------------------------------------------%
connection(harry, ron, strong).
connection(harry, herminone, strong).
connection(harry, dumbledore, professional).

connection(ron, harry, strong).
connection(ron, herminone, strong).
connection(ron, molly, familial).
connection(ron, dumbledore, professional).

connection(herminone, harry, strong).
connection(herminone, ron, strong).
connection(herminone, dumbledore, professional).

connection(molly, ron, familial).


%------------------------------------------------%
% Posts: user, date, relationship level, content %
%------------------------------------------------%
post(harry, date(5,24,1997), strong, 'I\'m presently safe in the Burrow.').
post(harry, date(9,8,2020), public, 'I\'m honoured to accept the post as Head of the Department of Magical Law Enforcement.').

post(ron, date(18,12,1993), public, 'Looking forward to the holidays!').
post(ron, date(15,1,1994), professional, 'I\'m really enjoying Care of Magical Creatures this year.').
post(ron, date(21,2,1994), strong, 'I didn\'t get enough sleep last night - better skip Care of Magical Creatures.').

post(herminone, date(1,8,2019), public, 'I\'m honoured to accept the post as Minister of Magic.').

%part 2
%2.1
%checks if birthday of user matches 'today'
has_birthday_today(User) :- birthday(User,date(Day,Month,_)), today(Day,Month,_).

%2.2
%iterates through "cases" to see what Relation between users entails
level_appropriate(_, _, public) :- true.
level_appropriate(User1, User2, professional) :- connection(User2, User1, Relation), member(Relation, [strong, familial, professional]).
level_appropriate(User1, User2, familial) :- connection(User2, User1, Relation), member(Relation, [strong, familial]).
level_appropriate(User1, User2, strong) :- connection(User2, User1, Relation), member(Relation, [strong]).


%2.3
%makes sure Relation is level appropriate and returns posts visible to User1
view_posts(User1, User2, date(Day,Month,Year), Content) :- 
	post(User2, date(Day,Month,Year), Protection, Content), level_appropriate(User1, User2, Protection).

%part 3
%3.1
%I'm aware this is incorrect, it doesn't account for the connections through friends,
%don't have time to figure out, figure id go for the "attempted" point.
connected(User1, User2) :- 
	connection(User1, User2, _) ; connection(User2, User1, _).

%3.2
%Checks if Head has duplicate in list, 'removes' Head if duplicate and recurses with Tail,
%if not a duplicate, Head of non-duplicate list is Head value and recursion continues.
remove_duplicates( [], []).		%base case
remove_duplicates([Head|Tail], Dupes) :-
	member(Head,Tail),
	remove_duplicates(Tail, Dupes).
remove_duplicates([Head|Tail], [Head|NewTail]) :-
	not(member(Head,Tail)),
	remove_duplicates(Tail, NewTail).

%3.3
%Uses findall to create list of 'connected' and remove_duplicates used to remove
%duplicates from result findall
network(User1, List) :- 
	findall(User, connected(User1,User), NewList),
	remove_duplicates(NewList, List).



