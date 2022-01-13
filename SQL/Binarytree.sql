/*
You are given a table, BST, containing two columns: N and P, where N represents the value of a node in Binary Tree, and P is the parent of N.
*/

Select N,
     CASE
        when P is null then 'Root'
        when N IN (Select P from BST) then 'Inner'
        else 'Leaf'
    End
from BST order by N;