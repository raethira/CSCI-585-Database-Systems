The ER diagram depicts a conceptual database design for micro-controller programming courses which are planned to be offered by a small "STEM" organization, during summer vacation.

Below are the design decisions made on developing the ER model:

Entities & attributes:
=====================

1.  STUDENTS:
    ========= 

STUDENTS entity has STUDENT_ID as the primary key, which is unique with regards to this STEM organization.  STUDENT_ID is an example of Surrogate primary key.  Each student is assigned to at least one project and a class which would take 6 weeks to complete as part of the curriculum.  This gives 1:M cardinality between STUDENTS & (CODING CLASSES, HANDS-ON PROJECTS, COURSE) entities.  Each student is given a schedule at the start of the curriculum.  I assumed that this schedule is a list of rooms having number, place, class/project, time for each student.  So, there exists a 1:M cardinality to the ROOMS entity.  A student may or may not check in books from the LIBRARY, giving rise to 0:M cardinality to the LIBRARY.  A student should take a PART for an associated PROJECT, leading to 1:M cardinality to PARTS.

Required attributes: 
--------------------
STUDENT_ID, PROJECT_NAME, CLASS_NAME, ROOM_NUMBER, PART_ID, LAST_NAME, FIRST_NAME, POSTAL_CODE, PROJECT_TABLE

I assumed PROJECT_TABLE would be given at the time of enrollment and will be the same till the end of the curriculum.  Projects are not associated with PROJECT_TABLE and can keep changing throughout the curriculum on the same assigned PROJECT_TABLE.  So, as a pre-requisite, we must aggregate students who have to take common projects for the entire curriculum and give them the same PROJECT_TABLE.  This would eventually give us a group of 4 students and PROJECT_TABLE could be used to identify the group number as well, thus avoiding redundancy for storing group details.

Another assumption is that all the above mentioned required attributes are pre-requisite for a student(minimum 1 class & project, and its related attributes).  Since the schedule is given at the beginning, ROOM_NUMBER is also a pre-requisite.  ISBN_LIBRARY is used to keep track of student check-ins from the library.

Multi-Valued attributes: 
-----------------------
PHONE_NUMBER, PROJECT_NAME, CLASS_NAME, ROOM_NUMBER, ISBN_LIBRARY, PART_ID, COURSE_ID (given student enrolls in more than one class/project).  

2.  CODING_CLASSES:
    ==============

CODING_CLASSES has unique CLASS_NAME throughout as a simple primary key.  A course may not be offered, but CLASS details can exist in the system.  Each CLASS has a different number of courses, having from 0:M cardinality to COURSES entity.  The same logic applies to STUDENTS entity as well.  PAY_RATE is used to store the salary/hour for the class for INSTRUCTORS payroll.  A class can be taught by several instructors, and an instructor can teach many classes.  Thus, we have an M:N cardinality with INSTRUCTORS entity.  This was resolved by a bridge entity called TEACH and it converts into two 0:M relationships.  This has a strong relationship with the Bridge table TEACH since it shares its primary key with the later primary keys set(subset).  There can be classes/project offered but no STUDENTS/INSTRUCTORS  might enroll in it.  This gives 0:M cardinality.    

Required attributes: 
--------------------
CLASS_NAME, PAY_RATE is mandatory to calculate salary for INSTRUCTORS.

Multi-Valued attributes: 
-----------------------
STUDENT_ID, FACULTY_ID, COURSE_ID (given a class contains more than one course).  

Derived attribute:
-----------------
SALARY - Salary can be derived using PAY_RATE attribute and HOURLY_CLASSES

3.  TEXTBOOKS:
    ==========

TEXTBOOKS has a unique ISBN_TEXT attribute which is an International Standard Book Number, thus making the fields unique and acting as a primary key.  This is a type of natural primary key.  The same textbook(filtered by TEXTBOOK_NAME) can be used across more than one COURSE and can be suggested by more than one INSTRUCTOR as well.  Or, not used but just stays in the stock.  This would give 0:M cardinality to these two entities.  But, my assumption here is with using ISBN as primary key, resulting in 0:1 cardinalities.

As for the text, a text can be used in multiple classes (eg 'Learning Python' could be used in Python I and Python II classes).  In any class, only one language is taught. Eg. classes could be titled Python 1, Python 2, Advanced Java, Ninja JavaScript (!), etc.

Required attributes: 
--------------------
ISBN_TEXT, TEXTBOOK_NAME


4.  HANDS-ON_PROJECTS:
    =================

HANDS-ON_PROJECTS entity has PROJECT_NAME attribute as the primary key.  Each project is based on a single micro-controller.  As CODING_CLASSES, a project can be just existing in the catalog, but no student/faculty enrolls in it(0:M cardinality).  I assumed that the concept of hierarchy like Class & Course exist for the Projects as well.  In other words, each project has courses under it.  Hence there exists a weak relationship with COURSES entity having 0:M cardinality.  Each project would require parts specific to it, having 1:M cardinality with PARTS entity.  Many instructors would oversee many projects and is optional for the instructor(another assumption).  This gives 0:M cardinality to INSTRUCTORS entity.

The supervision pays a higher rate and PAY_RATE attribute is used to store that information.  The projects are distinct from classes - there's no relation between them.  A class, or project, could have multiple offerings, that are taught by multiple instructors.

Required attributes: 
--------------------
PROJECT_NAME, PAY_RATE is mandatory to calculate salary for INSTRUCTORS.

Multi-Valued attributes: 
-----------------------
PART_ID, STUDENT_ID , FACULTY_ID, COURSE_ID 

Derived attribute:
-----------------
SALARY - Salary can be derived using PAY_RATE attribute and HOURLY_PROJECTS

5.  COURSES:
    =======

COURSES entity has COURSE_ID as its primary key.  Below are my design assumptions:
	- A course can/cannot be offered only under one class - 0:1 cardinality to CODING_CLASSES entity
	- A course can/cannot be offered only under one project - 0:1 cardinality to HAND-ON_PROJECTS entity
	- For a particular time slot, a course can be conducted only in one of the available rooms - 0:1 cardinality to ROOMS entity
	- Each course will be taught by only one professor - 0:1 cardinality to INSTRUCTORS entity
	- A course can be enrolled by 0 to many students - 0:M cardinality to STUDENTS entity
	- Each course has a textbook - 1:1 cardinality to TEXTBOOKS entity

Required attributes: 
--------------------
COURSE_ID, TIME, ROOM_NUMBER is mandatory to schedule a course.

Multi-Valued attributes: 
-----------------------
STUDENT_ID

6.  SUPPLIERS:
    ========= 

SUPPLIERS entity has VENDOR_NAME & PART_ID attribute as its primary key.  The owners of the institution order project parts from several online suppliers - 0:M cardinality with PARTS entity.  ORDER_QUANTITY keeps track of the number of ordered items.  There exists a strong relationship from SUPPLIERS to PARTS entity since the primary key PART_ID is being shared.

Required attributes: 
--------------------
VENDOR_NAME, PART_ID

Multi-Valued attributes: 
-----------------------
PART_ID

7.  ROOMS:
    ======

ROOMS entity has ROOM_NUMBER and TIME combined as its composite primary key.  Below are my design assumptions:
	- For a given time slot, the only course can happen at a time - 0:1 cardinality to COURSES entity
	- Students will be provided a schedule that will list where and when the rooms will be - 1:M cardinality to STUDENTS entity.

Required attributes: 
--------------------
ROOM_NUMBER, TIME

Multi-Valued attributes: 
-----------------------
STUDENT_ID, COURSE_ID

8.  LIBRARY:
    =======

LIBRARY entity has ISBN_LIBRARY attribute as its primary key.  A student can check out up to 4 books at a time(TIME_OF_CHECK_IN attribute), which need to be returned in 2 weeks(CHECKED_QUANTITY attribute).  Another functionality is the same as TEXTBOOKS entity.  The library won't have textbooks used in the courses, it'll have extra books that can help with coding, and with project creation.

Required attributes: 
--------------------
ISBN_LIBRARY, BOOK_NAME


9.  RATING:
    ======

RATING entity has STUDENT_ID has its primary key.  RATING entity could exist only when STUDENTS can rate, which makes it an existence dependent with STUDENT entity.  This has a strong relationship with STUDENTS entity as well(shared primary key), thus making it eligible for a weak entity.

Required attributes: 
--------------------
STUDENT_ID

10.  PARTS:
     ======

PARTS entity has PART_ID has its primary key.  Each part is associated with HANDS-ON_PROJECTS(0:1 cardinality) and hence STUDENTS(0:1 cardinality).  It is 0:1 cardinality since I assume to filter the results using PART_ID which is unique to every part under PART_NAME.  STOCK_QUANTITY is needed to keep track so that orders can be placed with SUPPLIERS entity(0:M cardinality) when it goes out of stock.  At the end of the term, students will return all the parts presumably in good working order, otherwise, they would be charged for damaged items.  DAMAGED_CHARGES attribute keeps track of student charges. 

Required attributes: 
--------------------
PART_ID, PART_NAME, STOCK_QUANTITY

11.  INSTRUCTORS:
     ===========

INSTRUCTORS entity has FACULTY_ID attribute as its primary key.  Basic functionality remains same as STUDENTS entity with additional attributes such as HOURS_CLASSES and HOURS_PROJECTS to keep track of total working hours.  Salary can be derived using this and PAY_RATE attribute.  I assumed that instructors can exist in the database without teaching any class or supervising project.

Required attributes: 
--------------------
FACULTY_ID, LAST_NAME, FIRST_NAME, POSTAL_CODE

Multi-Valued attributes: 
-----------------------
PHONE_NUMBER, CLASS_NAME, ISBN_TEXT, COURSE_ID, PROJECT_NAME (given faculty teaches/supervises more than one class/project).  

Derived attribute:
-----------------
SALARY


Entity Relationships:
=====================
		Weak entity = Existent dependent + Strong relationship(shared primary key)
		
Weak entities:
-------------
	TEACH, RATING 

