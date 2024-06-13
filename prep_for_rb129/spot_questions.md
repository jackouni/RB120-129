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

Duck typing solves the problem of the coupling of objects' behaviours to an inheritance hierarchy by using composition. Duck typing helps loosen the coupling between an object's behaviour to an inheritance hierarchy by allowing for **has-a** relationships to be formed between objects and their behaviours. This can allow for more adaptable, flexible and maintainable code. It eliminates the dependency on a Class in a hierachial chain to maintain the same defined behaviours that are compaitaible with all of the current subclasses today, in a program that will most likely be changing and redefining definitions and subclasses overtime.

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

