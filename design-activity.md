
###Questions

- What classes does each implementation include? Are the lists the same?
  - Both implementations have CartEntry, ShoppingCart, and Order. The lists are the same.

- Write down a sentence to describe each class.
  - The CartEntry class initializes the item in the cart using a unit price and quantity. In implementation b, it also defines the price.
  - The ShoppingCart class initializes the cart using the collection of entries In implementation b, it also defines the price.
  - The Order class initializes the order and defines the method of finding the total price.


- How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.


- What **data** does each class store? How (if at all) does this differ between the two implementations?
  - CartEntry, ShoppingCart, and Order each has the initialize method. Order also has the total_price method.
  - In implementation B, CartEntry and ShoppingCart also have a price method.


- What **methods** does each class have? How (if at all) does this differ between the two implementations?
- CartEntry has unit_price, quantity. ShoppingCart stores entries. Order stores total_price and cart.
- In implementation B, CartEntry and ShoppingCart also store price.


- Consider the `Order#total_price` method. In each implementation:
    - Is logic to compute the price delegated to "lower level" classes like `ShoppingCart` and `CartEntry`, or is it retained in `Order`?


    - Does `total_price` directly manipulate the instance variables of other classes?


- If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?


- Which implementation better adheres to the single responsibility principle?


- Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?



    Based on the answers to the above questions, identify one place in your Hotel project where a class takes on multiple roles, or directly modifies the attributes of another class. Describe in design-activity.md what changes you would need to make to improve this design, and how the resulting design would be an improvement.
