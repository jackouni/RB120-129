# What is OOP (object oriented programming)?

is a paradime in programming that was created to deal with the complexity of large applications and systems. OOP mostly revolves around the idea of encapsulating data and operations that can act on that data, into a single entity/container (known as an object). This allows for changes made to that data to be more contained to its entity/object as opposed to it having a larger ripple-effect throughout a program due to its dependencies. OOP is suppose to be a solution to

Changes to data in OOP code can also have a ripple-effect throughout an application and objects can have dependencies as well, but OOP allows for the easier containment and 'secitoning-off' of data and dependencies in an application which can help us better minimize these ripple-effects.

---

# What is encapsulation?

Encapsulation is the idea of containing data and operations that act upon that data to a single entity or container, known as an object. Encapsulation allows for objects to have **'state'** meaning it "owns" the data that is contained/associated with it and has access to the operations (**behaviour**) that can act upon its contained data. 

Additionally, encapsulation allows for state/data associated with an object to be hidden from external access. This acts as a way to protect data associated with an object, making manipulation to that data harder to do without obvious intent.

---

# How does encapsulation relate to the public interface of a class?

Public interfaces can be used as a way to gain access to certain or specific data associated with an object. Public interfaces are defined **instance methods** (a behaviour an object has access to) that can allow for internal access to the object from externally. 

With encapsulation, the state and private/protected behaviours of an object are contained or hidden from external access. With public interfaces **method access control** can be implemented, that is, exposing certain state and behaviour via an external interface.

---

# What is an object?

An object is an entity that contains/encapsulates data and operations that act upon that data (known as **state and behaviours**). Objects are created using classes that act as a blue print for creating/**instantiating** an object, defining data that will be associated with an object and the behaviours it will have access to.

An object **instantiated** from a class is known as an **instance** of that class. Each instance of a class will have it's own individual state but will share behaviours with other instances of the same class.

---

# What is a class?

A class serves as a blueprint for creating objects. A class can define the initial state of each instance of the class and the behaviours instances of that class will have access to. A class can also define class variables, class methods, constants, and inheritance from another class (a superclass). 

A class in Ruby is defined using the `class` keyword followed by the name of the class. The definition of the class is contained within `class...end`. Here's an example:

```ruby
class SomeClass
  BIG_CONSTANT = "Big Value!"
  @@instances_made = 0 # a class variable
  include Moduleable

  def initialize(value)
    @instance_var = value
    @@instances_made += 1
  end

  def some_instance_method
    # ...
  end

  def self.some_class_method
    # ...
  end
end

```

---

# What is instantiation?

Instantiation is the process of a new instance being created from a class. In Ruby instantiation is achieved through the use of the `new` method being invoked by a defined class (`new` may or may not take arguments depending on the `initialize` method's definition *(if it's been defined)* within the respective class definition)

Here's an example of instantiation in Ruby:
```ruby
class MyClass; end

instance_of_myclass = MyClass.new
```

In the above example, a new instance has been **instantiated** from the `MyClass` class and the local variable `instance_of_myclass` is intitialized to reference this new instance.

---

# What is polymorphism?

Polymorphism is the concept of objects of different types being able to respond to the same public interface. Being able to respond to a common public interface doesn't necessarily mean they will have the same output or results though.

For example: There could be a `speak` method. The `speak` method can be invoked by other types of objects whether `Human`, `AI` or `Parrot` instances, as long as the class defines or mixes in a `speak` instance method, then instances of the class can respond to a `speak` interface.

---

# Explain two different ways to implement polymorphism 

Two ways Polymorphism can be implemented is through duck-typing and inhertiance.

## Polymorphism through Inheritance

Polymorphism can be achieved through inhertiance by subclasses inheritting a behaviour from a shared superclass or by overriding a method in a subclass from its superclass.

Here's an example to illustrate:
```ruby
class Vehicle
  def drive
    "Driving on land road..."
  end
end 

class Car < Vehicle
end

class Truck < Vehicle
end

class Boat < Vehicle
  def drive
    "Driving on water..."
  end
end

car   = Car.new
truck = Truck.new
boat  = Boat.new

car.drive   # => "Driving on land..."
truck.drive # => "Driving on land..."
boat.drive  # => "Driving on water..."

```

In the example above there's a `Car`, `Truck` and `Boat` class. All of these classes are vehicles of some kind, hence why each subclasses to `Vehicle`. Most vehicles do drive on land, so it makes sense that `Vehicle#drive` returns `"Driving on land..."` and it makes sense that both subclasses `Car` and `Truck` don't need to define their own `drive` method as they can inherit this behaviour from their superclass. This would be polymorphism through inheritance. 

`Boat` is a bit different though because boats drive on water. `Boat` defines a `drive` method so that it can return a more appropriate value. `Boat#drive` is said to **override** the `Vehicle#drive` method as to not access its superclass' `Vehicle#drive` method. Overriding is generally considered to be an example of polymorphism through inheritance because overiding is considered to be a characteristic of inheritance. So, this too would be an example of polymorphism through inheritance. 

In this example, the classes share a common `drive` public interface. Each instantiates a different type of object but all instances will respond to the same method call, but behaviours may be different as shown with the return value of `boat.drive`.

### Polymorphism through Mixins

Similar to polymorphism through inheritance, modules used as mixins can be used to achieve polymorphism as well. Here's a remix of the code snippet from the last example to illustrate:
```ruby
module Driveable
  def drive
    "I'm driving!"
  end
end 

class Car
  include Driveable
end

class Truck
  include Driveable
end

car   = Car.new
truck = Truck.new

car.drive   # => "I'm driving!"
truck.drive # => "I'm driving!"

```

Again, `Car` and `Truck` respond to a common public interface despite being different object types. Instead of inheritance from a superclass, the `drive` method is mixed-into `Car` and `Truck` from the `Driveable` module.

## Polymorphism through Duck-Typing

Duck-Typing is similar in concept to *"overriding"* in that a method with the same name as a method of another object is being defined within a class. The difference is that inheritance isn't associated with it. Duck-Typing is when classes with no common superclass or inheritance hierarchy define methods with the same names.

Here's an example to illustrate:

```ruby
class Dice
  def roll
    rand(1..6)
  end
end

class Ball
  def roll
    "I am rolling"
  end
end

dice = Dice.new
ball = Ball.new

dice.roll # => 4 (return may vary)
ball.roll # => "I am rolling"

```
In the example above, `Dice` and `Ball` are completely unrelated classes, they don't share a common superclass or inheritance hierarchy *(technically both would inherit from the `Object` class, but specifically for this example I'm talking about inheritance from a class that I've created and implemented in the code)*.

As seen on the last 2 lines, both `Dice` and `Ball` instances respond to the public interface of `roll`, despite them being different types of objects. This is an example of polymorphism through duck-typing.

---

# How does polymorphism work in relation to the public interface?

Polymorphism is the concept of objects of different types being able to repsond to the same public interface. The relation between polymorphism and the public interface is that the same public interface can be defined for different objects, that is, the objects can respond to the same method name regardless of their differing object types.

--- 

# What is duck typing? How does it relate to polymorphism - what problem does it solve?

Duck typing is a form of polymorphism, in that it's a way for allowing objects of different types to respond to the same public interfaces, without relying on inheritance or explicit class hierarchies. This is polymorphism where shared interfaces is achieved through the use of mixins or by explicitly defining a behaviour with a common public interface within a class definition.

Duck typing solves the problem of the coupling of objects' behaviours to an inheritance hierarchy. Duck typing helps loosen the coupling between an object's behaviour to an inheritance hierarchy by allowing for **has-a** relationships to be formed between objects and their behaviours. This can allow for more adaptable, flexible and maintainable code. It eliminates the dependency on a Class in a hierachial chain to maintain the same defined behaviours that are compaitaible with all of the current subclasses today, in a program that will most likely be changing and redefining definitions and subclasses overtime.

Here's an example:

```ruby
class Dice
  def roll
    rand(1..6)
  end
end

class Ball
  def roll
    "I am rolling"
  end
end

dice = Dice.new
ball = Ball.new

dice.roll # => 4 (return may vary)
ball.roll # => "I am rolling"

```
In the example above, `Dice` and `Ball` are unrelated classes, they don't share a common superclass or inheritance hierarchy *(technically both would inherit from the `Object` class, but specifically for this example I'm talking about inheritance from a class that I've created and implemented in the code)*.

As seen on the last 2 lines, both `Dice` and `Ball` instances respond to the public interface of `roll`, despite them being different types of objects. This is an example of polymorphism through duck-typing.

---

# What is inheritance?

Inheritance is the concept of a child class (subclass) *inheritting* methods from a parent class(superclass).

This means instances of a subclass (and the subclass itself) have access to respective methods that are accessible to their superclasses. Ruby only allows for single inheritance though, meaning a subclass can only *directly* inherit from a single superclass.

In Ruby a superclass to a subclass can be defined by using the `<` keyword/operator following the defined subclass name and followed by the name of the class you want the subclass to inherit from. Here's an exmaple using a supposed banking app:

```ruby
class Account
  def initialize(starting_balance)
    @balance = starting_balance
  end

  def current_balance
    @balance
  end

  def self.who_am_i
    "Caller: #{self}"
  end
end

class SavingsAccount < Account
  @@apr = 0.5

  def apr
    "#{@@apr}%"
  end
end

savings = SavingsAccount.new(1000)
puts savings.current_balance #=> 1000
puts savings.apr             #=> 0.5%
```

The banking app contains varying types of accounts a customer can open. **All** accounts have a balance of some kind. One of these types of accounts is a savings account *(for the sake of simplicity and brevity the savings account at this institution is 0.5% apr, as represented by the class variable `@@apr`)*. 
In the example a class, `Account`, is created to represent any account in general and a class, `SavingsAccount`, is created to represent a savings account. Because `SavingsAccount` is a specialized type of `Account` it makes sense that it should be able to do the things `Account`s can do. Through inheritance, instances of `SavingsAccount` can access the behaviour defined in the superclass, `Account`. `SavingsAccount` *"inherits"* the behaviours `initialize(starting_balance)` and `current_balance` from `Account`. This allows for less repetition and more reusability in the codebase and can help structure things in a hierarchical pattern. If the application was to expand, there could be other accounts that inherit from `Account` like a `CheckingAccount`, `RothIRA`, `HSA` etc etc...

---

# What is the difference between a superclass and a subclass?

A subclass is a class that gains access to methods that are accessible to another class through the use of inheritance. A superclass is a class that a subclass is inheritting from. You could say a subclass inherits from a superclass. There's a hierarchical difference between a subclass and superclass, where the superclass is *"higher up"* in the hierarchy compared to the subclass.

---

# What is a module?

In Ruby, a module can be thought of as a container for methods, constants, and classes. Modules are generally used as mixins or for namespacing purposes.

Methods defined in a modules can be used as **mixins** to a class by using the `include` keyword, like so:
```ruby
module Speakable
  def say_name
    puts "My name is #{@name}"
  end

  def what_am_i
    puts "I'm a #{self.class}"
  end
end

class Human
  include Speakable # instances of Human can now access methods in the Speakable module

  def initialize(name)
    @name = name
  end
end

jeff = Human.new("Jeff")
jeff.say_name   #=> My name is Jeff 
jeff.what_am_i  #=> I'm a Human
```

---

# What is a mixin?

A **mixin** is when a module is used to *mix in* behaviour(s) to a class. The general use case for mixins is when objects of different types share behaviour, but inheritance is either not possible or not as optimal to use for sharing that behaviour between differnt object types. Less code can be written when using mixins to share behaviour between different object types/classes by allowing for instance methods to be written once, within the module, as opposed to being written out multiple times for each object type/class that shares the behaviour. 

Here's a practical example of a module being used as a *mixin*:
```ruby
module Speakable
  def speak
    "I am a #{self.class}. My name is #{@name}."
  end
end

class Human
  include Speakable

  def initialize(name)
    @name = name
  end
end

class Robot
  include Speakable

  def initialize(name)
    @name = name
  end
end

rob = Human.new('Rob')
robocop = Robot.new('Robocop')

p rob.speak     #=> "I am a Human. My name is Rob."
p robocop.speak #=> "I am a Robot. My name is Robocop."
```

---

# When is it good to use inheritance?

Inheritance might make more sense if types of objects have a natural hierarchical structure or order. When objects have a more *is-a* relationship between eachother. As an example: a Dog *is a* Mammal. This means using inhertiance to share behaviours from a Mammal to a Dog class might make more sense. Also, in situations where an object type is a specialized version of another object type, this could suggest using inheritance as well, where the subclass is a specialized version of the superclass it's inheritting from. These are scenarios where using inheritance would make sense.

#### Recap on when to consider using inheritance:
- Object types have an *is-a* relationship
- Object types follow a natural hierarchical pattern or order
- An Object type (subclass) is a more specialized version of another object type (a parent or superclass)

--- 

# In inheritance, when would it be good to override a method?

In inheritance, you might consider overriding a method when you want to change the behavior of a method inherited from a superclass in a specific subclass.

A practical example of this is `Object#to_s`, an instance method that returns the calling object's `String` counterpart. Custom objects in Ruby inherit from the `Object` class at some point in the hierarchical chain. By default `Object#to_s` returns a `String` a more "literal" representation of a custom made object *(like this, `#<CustomObj:0x000000010463da30>`)*. Typically this returned `String` is not desired when calling `#to_s` on a custom object. More commonly desired, the returned `String` of `#to_s` is of specific readable details of the custom object. Here's an example to illustrate:

```ruby
class Human
  def initialize(name)
    @name = name
  end
end

joe = Human.new("Joe")
puts joe 
# Actual Output:   #<Human:0x0000000105210600>
# Expected Output: Hi I'm Joe.

# `to_s` is automatically called on the argument in the implementation of `puts`.
#  This converts the argument to a `String` that can then be outputted by `puts`.

```

In the above example, we want instances of `Human` to output an introduction of themselves using their `@name` instance variable. Because `puts` calls `#to_s` on its arguments, the default `Object#to_s` is called on `joe`. This returns the `String` version of the literal object, as explained previously.

To get the desired output, we need to override the `Object#to_s` method by defining a `Human#to_s` like so:

```ruby
class Human
  def initialize(name)
    @name = name
  end

  def to_s
    "Hi, I'm #{@name}."
  end
end

joe = Human.new("Joe")
puts joe # Outputs: Hi, I'm Joe. 

# `to_s` is automatically called on the argument in the implementation of `puts`.
#  This converts the argument to a `String` that can then be outputted by `puts`.

```

Now `Human#to_s` is called on `joe` overriding `Object#to_s` and allowing for a more desired output. 

Another scenario for method overriding is when we want to extend the functionality of a superclass' method to a subclass. For example, upon instantiation of an instance of the subclass we want to initialize all the same instance variables as initialized in the `#initialize` of the superclass but include some extra instance variables for the subclass instances. Here's an illustration:

```ruby
class Employee
  def initialize(name)
    @name = name
  end
end

class SalesPerson < Employee
  def initialize(name, total_sales)
    super(name)
    @total_sales = total_sales
  end
end

jbelfort = SalesPerson.new("Jordan", 5041)

# `jbelfort` will have:
# a `@name` of `"Jordan"`
# a `@total_sales` of `5041`

```

In the example above, every `Employee` at the firm has a name, and are instantiated with a given name referenced by `@name`.
A `SalesPerson` *is-an* `Employee` and therefore should be instantiated with an initialized `@name`, like all other `Employee`. `SalesPerson`s unlike other roles in the company, have a number of their total sales, so upon instantiation should be initialized with a `@total_sales`. Using the `super` keyword, the `initialize` method can be called further up in the method-lookup path, calling `Employee#initialize`, then `@total_sales` can be initialized with in `SalesPerson#initialize` for the caller. This demonstrates using method overriding with `super` to extend superclass functionality.

---

# What is the method lookup path?

**Method lookup path** is the order in which Ruby searches for methods that are called in a program. Once the method that is being called is found, it can be invoked. When an object invokes a method, Ruby searches for the method that is being called in this order:

1. The class definition of the receiving object is searched </br> 
2. Any modules that are *mixed-into* the class definiton from the last module *included* in the definition to the first </br>
3. The superclass definition</br>
4. Any modules *mixed-into* the superclass from last *included* to first </br>
5. Each subsequent ancestor of the superclass and its *mixed-in* modules </br>

This pattern is repeated until the method is either found or not found and throws a no method error.

Here's an example to demonstrate a method lookup path:

```ruby
module Barkable
  def bark
    "Barking..."
  end
end

module Breathable
  def breath
    "Breathing..."
  end
end

class Animal
  include Breathable
end

class Dog < Animal
  include Barkable
end

dog = Dog.new
dog.breath # => "Breathing..."
dog.jump   # Error thrown: undefined method `jump' for #<Dog:0x0000000102aaf520> (NoMethodError)    

```

When `dog.breath` is called the method will be looked up in this order: </br>
`Dog` --> `Barkable` --> `Animal` --> `Breathable` </br>
(*`breath` is found in the `Breathable` module*)


When `dog.jump` is called the method will be looked up in this order: </br>
`Dog` --> `Barkable` --> `Animal` --> `Breathable` --> `Object` --> `Kernel` --> `BasicObject` </br>
*(`jump` is not found)*

This method lookup for `Dog` objects can be programmatically displayed using the `ancestors` method, like so: </br>
`Dog.ancestors #=> [Dog, Barkable, Animal, Breathable, Object, Kernel, BasicObject]`

---

# When defining a class, we usually focus on state and behaviors. What is the difference between these two concepts?

*"State"* refers to data that is associated with a specific instance of a class (instance variables), whereas *"behaviour"* refers to the methods (instance methods) that all instances of a class will have access to use. These behaviours are not unique to a single instance but are shared amongst the instances of the class. State is unqiue to individual instances of a class.

---

# How can we expose information about the state of the object using instance methods?

We can expose information about the state of an object by defining an instance method in the class definition and within that instance method's definition, referencing the instance variable associated with the calling object. Here's an example:

```ruby
class Human
  def initialize(name)
    @name = name
  end

  def name
    @name
  end
end

james = Human.new("James")
james.name #=> "James"

```

In the code above, the instance method `name` is defined within the `Human` class. Within this instance method we implicitly return the value of the `@name` instance variable associated with whatever the caller object is. In this example, when the `Human` object `james` invokes the `name` method, the value of `@name` is returned, `"James"`. This is known as a *creating a public interface* which allows us to *expose* information about the state of an object in our *global/outer* codebase.

---

# What is a collaborator object, and what is the purpose of using collaborator objects in OOP?

A collaborator object is an object that is a part of another object's state. Technically any object type that is a part of another object's state is a collaborator object, but generally when we mention collaborator objects we're talking about custom made types of objects that are assigned to the state of another custom made type of object.

The purpose of a collaborator object is to extend the functionality of an object to it's *collaboratee/owner*. Now that the collaborator object is a part of its owner's state, the owner can potentially access functionality of the collaborator. A collaborate also serve as a way to model real world relationships between entities. Here's an example:

```ruby

class PetOwner
  attr_reader :pet

  def initialize(name, pet)
    @name = name
    @pet = pet
  end

  def introduction
    puts "Hi I'm #{@name} and this is my pet #{pet.class}, #{pet.name}."
  end 
end

class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

kitty = Cat.new("Kit")
joe   = PetOwner.new("Joe", kitty)

joe.introduction # Outputs: "Hi I'm Joe and this is my pet Cat, Kit."

```

As seen in the above example, the `Cat` object `kitty` is a collaborator to the `Human` object `joe`, as seen with `kitty` being assigned to `joe`'s state in the `initialize` method *(`@pet = pet`)*. As demonstrated on the final line, we're able to extend the capabilities of `Human` by accessing the collaborator and its instance methods as seen with the interpolation of `pet.name` in `Human#introduction.

---

# What is an accessor method?

An accessor method is an instance method that is used to access or modify instance variables associated with an object. Here's an example of the 2 types of accessor methods, getters and setters:

```ruby
class MyClass
  def initialize(name)
    @name = name
  end

  def name
    @name
  end

  def name=(new_name)
    @name = new_name
  end
end

an_instance = MyClass.new('Insty')
an_instance.name #=> 'Insty'
an_instance.name = 'Random Name'
an_instance.name #=> 'Random Name'

```

As seen above instance methods `MyClass#name` is used to return the instance variable `@name` (getter) and `MyClass#name=` is used to modify the value of the instance variable `@name` (setter).

In Ruby there is a method called `attr_accessor` that can automatically create getters and setters for the method arguments passed to it. Here's an example of the use of `attr_accessor` to create accessor methods:

```ruby
class MyClass
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

an_instance = MyClass.new('Insty')
an_instance.name #=> 'Insty'
an_instance.name = 'Random Name'
an_instance.name #=> 'Random Name'

```

# How do you decide whether to reference an instance variable or a getter method?

---

# When would you call a method with self?

There are a few circumstances where you would want to use `self` to call a method but there is one main reason that `self` is used to call methods in. `self` is used to explicitly call setter methods in Ruby. Otherwise Ruby will mistaken the setter method call for a local variable reassignment. Like in this example:

```ruby
class Human
  attr_reader :name

  def name=(new_name) # setter method for @name
    @name = new_name
  end

  def initialize(name)
    @name = name
  end

  def capitalize_name
    name = name.capitalize
  end
end

me = Human.new('jack')
p me.name            #=> 'jack'
me.capitalize_name #=> NoMethodError
```

As seen above, the `Human#capitalize_name` is throwing an error. This is happening because Ruby is interpretting `name = name.capitalize` as a new local variable as opposed to the setter method `name=(new_name)`. The error is thrown because we're initializing a new local variable that is referencing itself with `String#capitalize` invoked on it, and because it hasn't been assigned to a value yet, it returns `nil`.

To give Ruby context we need to explicitly tell it that we're calling `name=(new_name)` for the current instance. We can do this by using `self` to represent the current calling instance:

```ruby
class Human
  attr_reader :name

  def name=(new_name) # setter method for @name
    @name = new_name
  end

  def initialize(name)
    @name = name
  end

  def capitalize_name
    self.name = name.capitalize
  end
end

me = Human.new('jack')
p me.name            #=> 'jack'
me.capitalize_name 
p me.name            #=> 'Jack'
```

As seen above, the `capitalize_name` method now successfully accesses the setter method `name=(new_name)` because we've explicitly called it using `self`.

---

# What is `self`?

`self` represents an object. `self` represents different objects depending on its context. Here are some of the main contexts `self` can be used in in object oriented Ruby and what it represents for each context:

Here's an example:

```ruby
class SampleClass
  def self.class_method # Used to define a class method
    self # Within a class method
  end

  def some_instance_method
    self # Within an instance method
  end

  def value=(new_value)
    @value = new_value
  end

  def change_value
    self.value = "new value"
  end
end

p SampleClass.class_method          #=> SampleClass
new_instance = SampleClass.new
new_instance.change_value
p new_instance.some_instance_method #=> #<SampleClass:0x000000010072ff50 @value="new value">
```

In the first main context **"used to define a class method"** `self` represents the Class object itself, and when prepended to a defined method name, symbolizes that the method is a class method.

In the second context **"within a class method"** `self` represents the class object itself. In the case of the example `self` will return `SampleClass`.

In the third context **"within an instance method"** `self` represents the calling instance that is invoking the respective instance method. To demonstrate, the final line, `new_instance.some_instance_method`, returns `new_instance`.

`self` is also used to disambugate between local variables and method calls. This is demonstrated in the `change_value` instance method, where `self.value = "new value"` is invoked, what's happening here is that `value=(new_value)` method is being invoked on the calling/recieving instance. Without `self` prepended to `value=(new_value)` Ruby would interpret this as a local variable, `value`, being initialized (`value = "new value"`).

---

#