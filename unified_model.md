# Launch School

Launch School is a site that has Students and Employees.
Types of Employees include: 
- Teaching Assistant
- Human Resource
- Manager
- Moderator
- CEO
- Developer

---

---

# When creating a hierarchical structure, under what circumstance would a module be useful?

It makes sense to use modules when class inheritance cannot be used to share behaviour between classes on different sides of the hierarchical tree or when you need to share a set of behaviour between multiple unrelated classes. 

Here's an example of where you might want to consider using a module:
```ruby
module Payrollable
  def deliver_payroll
    "Payroll delivered"
  end
end

class Employee
end

class TeachingAssistant < Employee
end

class CEO < Employee
  include Payrollable
end

class Accountant < Employee
  include Payrollable
end

CEO.new.deliver_payroll        #=> "Payroll delivered"
Accountant.new.deliver_payroll #=> "Payroll delivered"
```

In this example, we have a strucutre to represent types of `Employee` at Launch School. In this example there are 3 types of `Employee` defined; `TeachingAssistant`, `CEO` and `Accountant`. In this example we want to give certain `Employee` types a behaviour to allow them to give out payroll, those types being `CEO` and `Accountant`. In this case we can't define the behaviour in the `Employee` superclass, because then `TeachingAssistant` would be able to give our payroll, which is not what we want. Second option is we could define the behaviour in both `CEO` and `Accountant`, but then we would be repeating ourselves. 

Modules may also be considered when two objects have less of an **"is-a"** relationship and more of a **"has-a"** relationship. If object `A` can be describe like: *"`A` is-a type of `B`"* then you may want to consider a class inheritance structure. 

Another consideration for modules is being able to mixin as many modules as you want into a class but only being able to inherit from a single superclass per class. If there is a case where you need to mixin multiple different sets of behaviours into a class then you might want to consider placing the different sets of behaviours into their own module.

This is where we would use a module to define a set of related behaviours and `include` them in select classes. By doing so, we can share the `Payrollable` behaviours with `CEO` and `Accountant` without using class inheritance or having to repeat ourselves.


### Recap:
- Modules should be considered when an obvious *"is-a"* relationship is not found between two object types
- Modules should be considered when you want to share behaviour between unrelated or distant object tpyes
- Subclasses can only inherit from exactly 1 superclass, whereas 

---

# Describe the use of modules as containers.

Modules can be used as containers to bundle classes and constants under an appropriate label that adds context, readability and organization to the code. This idea is often known as **namespacing**. This means we can have classes with same names in our application, but contained within differently named modules that act as a way to avoid naming collisions. Here's an example:

```ruby
module Core
  BASE_SALARY = 50_000

  class TeachingAssistant
  end
end

module Capstone
  BASE_SALARY = 70_000

  class TeachingAssistant
  end
end

core_ta     = Core::TeachingAssistant.new
capstone_ta = Capstone::TeachingAssistant.new

Core::BASE_SALARY     #=> 50000
Capstone::BASE_SALARY #=> 70000
```

In the above example, you can see that there are two `TeachingAssistant` classes defined, but each is a different object type. Launch School has `TeachingAssistant` for both the `Core` and `Capstone` portions of the curriculum who have different responsibilities and differing base salaries. Now we can instantiate each type of `TeachingAssistant` without name collisions and with better context given to their purposes through the use of the module names used.

---

# What is polymorphism?

Polymorphism is the concept of objects of different types being able to respond to the same public interface. Here's a code snippet to demonstrate polymorphism:

```ruby
class Meeting
  def preparing_meeting(attendees)
    attendees.each { |attendee| attendee.prepare_for_meeting }
  end
end

class TA
  def prepare_for_meeting
    "prepare study materials"
  end
end

class Manager
  def prepare_for_meeting
    "prepare notes"
  end
end

class CEO
  def prepare_for_meeting
    "Prep investor notes"
  end
end

july_meeting = Meeting.new

attendees = [CEO.new, Manager.new, TA.new]
july_meeting.preparing_meeting(attendees)
# => "Prep investor notes"
# => "Prepare notes"
# => "Prepare study materials"
```

As seen in the above code example, each different employee type responds to the same public interface, `#prepare_for_meeting`.

---

# What is duck typing? How does it relate to polymorphism - what problem does it solve?

Duck-typing is way to implement polymorphism. Duck-typing is when a behaviour with the same name is defined in two or more unrelated classes. This way, objects of differing types can respond to the same public interface, this concept is known as polymorphism. 

Duck-typing solves the problem of objects being rigidly tied to an inheritance hierarchy. Duck-typing focuses on *what an object can do (its behaviours)* as opposed to *what an object is (in the case of inheritance)*. This can allow for more adaptable and flexible code, with the focus being on defining what an object can do as opposed to trying to define what the object is related to and what behaviour the related object has.

*"If it quacks like a duck, then we treat it like a duck."*

Here's an example of duck-typing in action:
```ruby
class Meeting
  def preparing_meeting(attendees)
    attendees.each { |attendee| attendee.prepare_for_meeting(self) }
  end
end

class TA
  def prepare_for_meeting(meeting)
    "prepare study materials"
  end
end

class Manager
  def prepare_for_meeting(meeting)
    "prepare notes"
  end
end

class CEO
  def prepare_for_meeting(meeting)
    "Prep investor notes"
  end
end

july_meeting = Meeting.new

attendees = [CEO.new, Manager.new, TA.new]
july_meeting.preparing_meeting(attendees)
# => "Prep investor notes"
# => "Prepare notes"
# => "Prepare study materials"
```

As seen above, each of the employee object types define their own `#prepare_for_meeting` method which allows them to be used by instances of a `Meeting` in preparation for the meeting. This can allow for more flexibility and adaptability, letting us define and tweak the specific `#prepare_for_meeting` behaviours for each object type as opposed trying to engineer the behaviour around potentially complicated and changing inheritance hierarchies.

---
