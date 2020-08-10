//Author: Ryan Protheroe
//Date: February 25th, 2019
package Assignments;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class Assignment2 {

    //interface for stack ADT / methods required in ADT
    public interface stackMethods {

        boolean isEmpty();

        void push(Object item);

        Object pop();

        Object top();

        int size();
    }

    //stack ADT
    public static abstract class Stack implements stackMethods {

        //Stack is array based
        Object[] items;
        //empty stack has "index" of -1
        int top = -1;
        int maxSize;

        public Stack(int size) {
            this.maxSize = size;
            this.items = new Object[size];
        }

        @Override
        //(index of "top"+1) = size of array
        public int size() {
            return (this.top + 1);
        }

        @Override
        //checks index
        public boolean isEmpty() {
            return (this.top < 0);
        }

        //Helper function for push
        public boolean isFull() {
            return (this.size() == this.maxSize);
        }

        @Override
        public Object top() {
            if (!isEmpty()) {   //can only get a top that exists/ stack isnt empty
                return this.items[this.top];    //doesnt get rid of value
            } else {    //checks empty case
                System.out.println("ERROR: Stack is Empty");
                return null;
            }
        }

        @Override
        public void push(Object item) {
            if (!isFull()) {    //can only push if stack isnt full
                this.top++;     //increase index
                this.items[top] = item;     //add value to array/stack
            } else {
                System.out.println("ERROR: Stack is Full");
            }
        }

        @Override
        public Object pop() {
            if (!isEmpty()) {   //can only pop a non-empty stack
                Object item = this.items[top];
                this.items[top] = null; //rids stack of popped value
                this.top--; //sets top index to next value in stack
                return item;   
            } else { //if empty
                System.out.println("ERROR: Stack is Empty");
                return null;
            }
        }
    }

    public static class BinarySearchTree {
        
        //attributes to BinarySearchTree
        int data;
        BinarySearchTree left;      //use other trees instead of a node class
        BinarySearchTree right;     //but I will refer to them as nodes
        int depth;      //have depth for use in getTotalDepth()

        //constrctor for tree
        public BinarySearchTree(int value) {
            this.data = value;
            this.left = null;
            this.right = null;
            this.depth = 0;
        }

        //constructor used for insert, needs depth as parameter
        private BinarySearchTree(int value, int depth) {
            this.data = value;
            this.left = null;
            this.right = null;
            this.depth = depth;
        }

        //sends to helper function which counts depth recursively
        public void insert(int value) {
            insert(value, 1);
        }

        private void insert(int value, int depthCount) {
            if (value > this.data) {    //check which side to take, left or right
                if (this.right != null) {   //checks if current "node" has children
                    this.right.insert(value, depthCount + 1);   //depth+1 if child
                } else {
                    this.right = new BinarySearchTree(value, depthCount);   //adds valueif no child
                }
            } else if (value < this.data) { //same as above, only for left side
                if (this.left != null) {
                    this.left.insert(value, depthCount + 1);
                } else {
                    this.left = new BinarySearchTree(value, depthCount);
                }
            } else {    //no duplicate values on tree
                System.out.println("ERROR: Node '" + value + "' is already in the tree.");
            }
        }

        // sends to recursive function
        public List<Integer> searchPath(int value) {
            List<Integer> path = new ArrayList<>(); //used arraylist to bypass size restrictions of arrays / didnt want hard array sizez
            path.add(this.data);    //adds root to list
            if (this.data < value) {    //checks with path to take based on search value
                return this.right.searchPath(value, path);  //sends to recursive function
            } else if (this.data > value) {
                return this.left.searchPath(value, path);  
            } else {
                return path;    //return root if looking for that value
            }
        }

        //helper function for searchPath
        private List<Integer> searchPath(int value, List<Integer> path) {
            path.add(this.data);    //add current node value
            if (this.data < value) {    //checks where to go next
                if (this.right != null) {   //checks for children
                    return this.right.searchPath(value, path);
                } else { //case of value not existing where it should be
                    System.out.print("Item not in tree, but this would be its path: ");
                    path.add(value);
                    return path;
                }
            } else if (this.data > value) {
                if (this.left != null) {
                    return this.left.searchPath(value, path);
                } else { //case of value not existing where it should be
                    System.out.print("Item not in tree, but this would be its path: ");
                    path.add(value);
                    return path;
                }
            } else {    //value is found, returns path array
                return path;   
            }
        }

        //adds up depth from each node recursively
        public int getTotalDepth() {
            if (this.right == null && this.left == null) {
                return this.depth;
            } else if (this.right != null && this.left != null) {
                return this.depth + this.left.getTotalDepth() + this.right.getTotalDepth();
            } else if (this.right != null && this.left == null) {
                return this.depth + this.right.getTotalDepth();
            } else {
                return this.depth + this.left.getTotalDepth();
            }
        }
        
        private int WeightBalanceHelper() {
            if (this.right == null && this.left == null) {  //base case/ hits an "end"
                return 0;   
            } else if (this.right != null && this.left != null) {
                return this.left.WeightBalanceHelper() + this.right.WeightBalanceHelper();  //no imbalance
            } else if (this.right != null && this.left == null) {
                return -1 + this.right.WeightBalanceHelper();   //subtracts 1 if node has no left child
            } else {
                return 1 + this.left.WeightBalanceHelper(); //adds 1 if node has no right child
            }
        }

        public int getWeightBalanceFactor() {
            return Math.abs(this.WeightBalanceHelper());    //gets absolute value of imbalance
        }

        //throws exception for file that doesnt exist/wrong name
        public static BinarySearchTree loadTreeFromFile(String fileName) throws FileNotFoundException {
            Stack stack = new Stack(100) {  //creates stack, assumed 100 is safe size for trees you'd be testing
            };
            File file = new File(fileName); //gets file
            Scanner input = new Scanner(file);  //file readers
            while (input.hasNextLine()) {   //runs while file still has lines
                Object right_tree = null;   //sets null trees/ children
                Object left_tree = null;
                String[] currentLine = (input.nextLine()).split("\\s+");    //puts current line into array indexed appropriately
                if (Integer.parseInt(currentLine[2]) == 1) {    //checks for right child
                    right_tree = stack.pop();
                }
                if (Integer.parseInt(currentLine[1]) == 1) {//checks for left child
                    left_tree = stack.pop();
                }
                BinarySearchTree tree = new BinarySearchTree(Integer.parseInt(currentLine[0])); //creates tree
                tree.left = (BinarySearchTree) left_tree;   //sets children of current node
                tree.right = (BinarySearchTree) right_tree; //children null be default, no need for cases here
                stack.push(tree);   
            }
            return reconstruct((BinarySearchTree) stack.pop()); //reconstruct helper
        }

        //Helper for reconstruct, puts BST in order of inserts/ pre-order
        public List<Integer> preOrderArray() {
            List<Integer> result = new ArrayList<>();   //use liat because I dodnt want to hard code size
            preOrderArrayHelp(this, result);    //send to helper
            return result;
        }
        
        private void preOrderArrayHelp(BinarySearchTree tree, List<Integer> result) {
            if (tree == null) { //return if "end" of tree
                return;
            }
            result.add(tree.data);  //adds current value of node
            preOrderArrayHelp(tree.left, result);   //recursive call for left and right children
            preOrderArrayHelp(tree.right, result);  
        }

        //Needed for total depth to work when loading from file, total depth reiles on insert
        private static BinarySearchTree reconstruct(BinarySearchTree tree) {
            List<Integer> preOrder = tree.preOrderArray();  //gets preorder of tree
            BinarySearchTree newTree = new BinarySearchTree(preOrder.get(0));   //create new tree
            for (int i = 1; i < preOrder.size(); i++) {
                newTree.insert(preOrder.get(i));    //inserts values into tree by pre-order
            }
            return newTree; //returns tree that has getTotalDepth() capabilities
        }
    }

    public static void main(String[] args) throws FileNotFoundException {
        //TESTING CODE
        //As far as im aware, it returns the correct values
        BinarySearchTree tree = BinarySearchTree.loadTreeFromFile("test.txt");
        System.out.println("Total Depth: " + tree.getTotalDepth());
        System.out.println("weight: " + tree.getWeightBalanceFactor());
        tree.insert(5);
        System.out.println(tree.searchPath(5));
        System.out.println("Total Depth: " + tree.getTotalDepth());
        System.out.println("weight: " + tree.getWeightBalanceFactor());
        
        //BST used in figure one and 2
//        BinarySearchTree tree = new BinarySearchTree(8);
//        tree.insert(4);
//        tree.insert(9);
//        tree.insert(2);
//        tree.insert(7);
//        tree.insert(10);
//        BinarySearchTree tree = new BinarySearchTree(6);
//        tree.insert(4);
//        tree.insert(9);
//        tree.insert(5);
//        tree.insert(8);
//        tree.insert(7);
    }
}

//not sure if you cared to see this or not
//        //STACK TESTING
//        Stack test = new Stack(10) {
//        };
//        System.out.println(test.isEmpty());
//        System.out.println(test.pop());
//        System.out.println(test.top());
//        System.out.println(test.size());
//        test.push(12);
//        test.push("yes");
//        test.push("a");
//        test.push(123);
//        System.out.println(test.top());
//        System.out.println(test.size());
//        Object check = test.pop();
//        System.out.println(check);
//        System.out.println(test.size());
//        System.out.println(test.top());
//        System.out.println(test.pop());
//        System.out.println(test.pop());
//        System.out.println(test.pop());
//        System.out.println(test.pop());

