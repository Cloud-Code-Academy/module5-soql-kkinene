public class MyClass{
    //Below is a static var that belongs to the class. It is the only one for the entire class
    public static Integer staticVar =100;

    //Below is an instance variable. A seperate copy of this variable is created for each instance of the class that is created
    public Integer instanceVar=200;

    //Below is static method, that can be called w/o creating an instance of the class. * It can only access static variables directly, not instance variables.
    public static void staticMethod(){
        System.debug('This is a static method. Static var value'+ staticvar);
        //System.debu('Instance var: '+instanceVar);// uncommenting would cause an error.
    }

    //Below is an instance method. It must be called on an instance of the class. It can access both static and instance var directly.
    public void instanceMethod(){
        System.debug('This is an instance Method. Instance Var value : '+ instanceVar);
        System.debug('Static var value: '+staticVar);
    }
}

//to use the above class and its methods:
//Call the static method directly on the class.
MyClass.staticMethod();

//create an instance of the class
MyClass myInstance= newMyClass();

//Call the instance method on the instance
myInstance.instanceMethod();

//Access the static var directly on the class
System.debug('Static Var accessed directly: '+ MyClass.staticVar);

//Access the instance variable on the instance
Sytem.debug('Instance variable accessed throught instance '+myInstance.instanceVar);