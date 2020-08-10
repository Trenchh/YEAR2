/*
 * Name: Assignment1.java
 * Date: January 12th, 2019
 * Version: v0.1
 * Author: Ryan Protheroe (20069587)
 */
package Assignment1;

public class Assignment1 {

    public interface BagRequirements {

        boolean add(Object item);

        boolean remove(Object item);

        boolean contains(Object item);

        int numItems();

        Object grab();

        void __str__();

    }

    public static abstract class Bag implements BagRequirements {

        Object[] items;
        int numItems;

        public Bag(int size) {
            this.items = new Object[size];
            this.numItems = 0;
        }

        @Override
        public boolean add(Object item) {
            for (int i = 0; i < this.items.length; i++) {
                if (this.items[i] == null) {
                    this.items[i] = item;
                    System.out.println("Item Added.");
                    this.numItems++;
                    return true;
                }
            }
            System.out.println("Error: Bag Full.");
            return false;
        }

        @Override
        public boolean remove(Object item) {
            for (int i = 0; i < this.items.length; i++) {
                if (this.items[i] == item) {
                    this.items[i] = null;
                    System.out.println("Item Removed.");
                    this.numItems--;
                    return true;
                }
            }
            System.out.println("Error: Item not found.");
            return false;
        }

        @Override
        public boolean contains(Object item) {
            for (int i = 0; i < this.items.length; i++) {
                if (this.items[i] == item) {
                    System.out.println("Item in bag.");
                    return true;
                }
            }
            System.out.println("Item not in bag.");
            return false;
        }

        @Override
        public int numItems() {
            return this.numItems;
        }

        @Override
        public Object grab() {
            Object random = null;
            while (random == null) {
                random = this.items[(int) Math.floor(Math.random() * (this.items.length))];
            }
            return random;
        }

        @Override
        public void __str__() {
            if (this.numItems != 0) {
                for (int i = 0; i < this.items.length; i++) {
                    if (this.items[i] != null) {
                        System.out.print(this.items[i] + ", ");
                    }
                }
                System.out.println();
            } else {
                System.out.println("The bag is empty.");
            }
        }
    }

    //testing
    public static void main(String[] args) {
        Bag testBag = new Bag(1000) {
        };

        //testing add
        testBag.__str__();
        testBag.add(1);
        testBag.add(2);
        testBag.add(3);
        testBag.add(3);

        //test display
        testBag.__str__();

        //test remove
        testBag.remove(3);
        testBag.__str__();

        //test contains
        testBag.contains(0);
        testBag.contains(2);

        //test adding strings
        testBag.add("dog");
        testBag.add("cat");
        testBag.__str__();

        //test grab
        Object item = testBag.grab();
        System.out.println("Grab test: " + item);
        testBag.__str__();

        //test numItems
        int number = testBag.numItems();
        System.out.println(number + " item(s) in bag.");
        testBag.__str__();

        //Other
        testBag.contains("mouse");  //false
        testBag.remove("mouse");    //false
        testBag.remove("dog");      //true
        testBag.__str__();
        testBag.contains("dog");    //false

        //test numItems
        number = testBag.numItems();
        System.out.println(number + " item(s) in bag.");
        testBag.__str__();

    }
}







/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Assignment1;

/**
 *
 * @author Swag God
 */
public class Assignment1part2 {

    public static int[] createList(int size) {
        int[] list = new int[size];
        for (int i = 0; i < list.length; i++) {
            list[i] = ((int) Math.floor(Math.random() * 5001)) * 2; //range of 10000 only even numbers
        }
        return list;
    }
    
    public static int[] searchValues(int size, int[]list) {
        int[] searchValues = new int[size];
        for(int i=0; i < size;i++) {
            if(i < (size/2)) {
                searchValues[i] = list[(int) Math.floor(Math.random() * (list.length + 1))];
            }
            else {
                //all even numbers in generator, but added 1 to make odd
                searchValues[i] =(((int) Math.floor(Math.random() * 5000)) * 2) + 1;
            }
        }
        return searchValues;
    }

    public static boolean linearSearch(int[] list, int value) {
        for (int i = 0; i < list.length; i++) {
            if (list[i] == value) {
                return true;
            }
        }
        return false;
    }

    public static boolean binarySeacrh(int[] list, int value) {
        int l = 0;
        int r = list.length - 1;
        while (l <= r) {
            int mid = l + (r - l) / 2;
            if (list[mid] == value) {
                return true;
            }
            if (list[mid] < value) {
                l = mid + 1;
            } else {
                r = mid - 1;
            }
        }
        return false;
    }

    public static int partition(int[] list, int low, int high) {
        int pivot = list[high];
        int i = (low - 1);
        for (int j = low; j < high; j++) {
            if (list[j] <= pivot) {
                i++;
                int temp = list[i];
                list[i] = list[j];
                list[j] = temp;
            }
        }
        int temp = list[i + 1];
        list[i + 1] = list[high];
        list[high] = temp;
        return i + 1;
    }

    /* The main function that implements QuickSort() 
      arr[] --> Array to be sorted, 
      low  --> Starting index, 
      high  --> Ending index */
    public void sort(int[] list, int low, int high) {
        if (low < high) {
            int partitionIndex = partition(list, low, high);
            sort(list, low, partitionIndex - 1);
            sort(list, partitionIndex + 1, high);
        }
    }

    public static void main(String[] args) {
        int[] list = createList(1000);
        int[] search = searchValues(10, list);
        
        long startTime = System.nanoTime();
        for(int i = 0; i < search.length; i++) {
            linearSearch(list,search[i]);
        }
        long endTime = System.nanoTime();
        long duration = (endTime - startTime);
        System.out.println(duration);
        
    }
}
