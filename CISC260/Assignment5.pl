%By: Ryan Protheroe
%Due: April 9th, 2019

%Didn't have time to complete this assignment, had more pressing issues at hand.
% sorry :(

%Part 1
%Sample Facts
mmyws(ium+titan/2010/300/224507).
mmyws(ium+titan/2011/300/262391).
mmyws(ium+titan/2012/400/267041).
mmyws(ium+titan/2013/500/268842).
mmyws(ium+titan/2014/500/263528).

mmyws(ium+pluton/2010/300/99356).
mmyws(ium+pluton/2011/300/76184).
mmyws(ium+pluton/2012/300/65830).

mmyws(ium+zircon/2010/400/326624).
mmyws(ium+zircon/2011/400/337295).
mmyws(ium+zircon/2012/500/332653).
mmyws(ium+zircon/2013/500/330106).
mmyws(ium+zircon/2014/500/335865).

mmyws(cosmos+dyne/2010/400/145522).
mmyws(cosmos+dyne/2011/500/149490).
mmyws(cosmos+dyne/2012/500/151870).
mmyws(cosmos+dyne/2013/500/149911).
mmyws(cosmos+dyne/2014/500/149405).

mmyws(cosmos+flux/2010/300/106221).
mmyws(cosmos+flux/2011/300/105672).
mmyws(cosmos+flux/2012/300/105079).
mmyws(cosmos+flux/2013/300/110415).

mmyws(cosmos+orbit/2010/400/85164).
mmyws(cosmos+orbit/2011/400/82390).

%1.1
currency_round(X, Y) :- Y is (round((X * 100)) / 100).

%1.2
%recall_information(mmyws(Make+Model/Year/WidgetType/NumberSold), Num) :-

print_list([]).
print_list([Head|Tail]) :-
  format('~w~n', Head),
  print_list(Tail).
  
%2.1
foldl1(Predicate, [X,Y|Ys], Num) :-
	call(Predicate, X, Y, Result),
	foldl1(Predicate, [Result|Ys], Num).
	
%2.2
%foldr1()