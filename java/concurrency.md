Do not allow the `this` reference to escape during construction.

thread confinement - do not share with other threads, automatically thread-safe. It is element of program's  design. 
 - local variables and ThreadLocal[?] class are helpful

JDBC specification does not require that Connection object be thread-safe. Connectio Pool - yes, this is thread-safe, since many threads access such structure. Requests are processed synchronously by a single thread, the pool will not give access to connection being used to another thread, therfore this pattern of connection management implicitly confined the Connection to that thread for the duration of the request.

ad-hoc thread confinement[?] - fragile, as no mechanisms guard it
 - https://stackoverflow.com/questions/9039503/example-of-ad-hoc-thread-confinement-in-java
 - according to link, it's more about informing other devs that they should use described element of the system in spefic way

Single threaded systems pros:
 - simplicity
 - out-of-the-box thread confinement
 - deadlock avoidance - one of the primary reasons most GUI frameworks are single-threaded 

Stack confinement (or `withing-thread`/`thread-local usage`):
 - special case of `thread confinement`
 - object can only be reached through local variables - by definition, exists on thread's local stack, not accessible by other threads
   (https://www.baeldung.com/java-local-variables-thread-safe)[?]
 - simpler to maintain, less fragile ad-hoc thread confinement
 - for primitives: language semantics ensure it - just a simple variable in method cannot be used in other thread or referenced
 - for objects: beware of escaping
 - using non-thread safe object in within-threads is thread-safe


### ThreadLocal

ThreadLocal:
 - formal way to maintain thread confinement
 - allows to associate per-thread value with value-holding object, conceptually - `Map<Thread, T>`
 - get/set methods
 - gets and sets only by current thread
 - used to prevent sharing in designs based on mutable SDingletons or global variables, usually static fields of a class
 - used when frequently used operation requires temporary object such as buffer and want to avoid its reallocation
 - J2EE container uses it to bind transaction to thread  for the duration of EJB call

``` java
   
import java.util.concurrent.Executors;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.stream.IntStream;

public class ThreadLocalFun {

    private static ThreadLocal<Long> SEXIER_ID_HOLDER = ThreadLocal.withInitial(() -> -2L);

 private static void useSexierIdHolder() {
        System.out.println("Main thread "+ Thread.currentThread().threadId() + ": " + SEXIER_ID_HOLDER.get());
        SEXIER_ID_HOLDER.set(SEXIER_ID_HOLDER.get() + 1);
        System.out.println("Main thread "+ Thread.currentThread().threadId() + ": " + SEXIER_ID_HOLDER.get());

        try (ThreadPoolExecutor executor = (ThreadPoolExecutor) Executors.newFixedThreadPool(3)) {
            IntStream.range(0, 10).forEach(c -> {
                executor.submit(() -> {
                    var currentValue = SEXIER_ID_HOLDER.get();
                    SEXIER_ID_HOLDER.set(SEXIER_ID_HOLDER.get() + 1);
                    System.out.println("Thread " + Thread.currentThread().threadId() + ": old value - " + currentValue + ", new value: " + SEXIER_ID_HOLDER.get());
                });
            });
        }
    }
}
```

### Immutability

Atomicity and visibility hazards:
 - seeing stale values
 - losing updates
 - observing and object to be in an inconsistent state
are coming from changing mutable state by many threads. If it cannot be changed - no problems.

immutable - objects which state cannot be changed after construction. Thread-safe.

Immutable objects are `simple`, `safer`.
 - its state cannot be modified after construction
 - all its fields are final (although they can hold reference to mutable objects, hence other rules)
 - it is properly constructed (`this` reference does not escape during construction)

Final fields:
 - make possible the guarantee of `initialization safety`, which lets immutable objects be freely accessed and shared without synchronization.
 - class is simplier with even some final fields, as some immutability restricts amount of possible states for class
 - show developers such variable is not expected to change

Just as it is a good practice to make all fields `private` unless they need  greater visibility, it is a good practice to make all fields final unless they need to be mutable.

Whenever items must be acted on atomically, consider creating an immutable holder class for them. Each thread has immutable copy - no worry about other thread modifying state, also always in valid state.

partially constructed object - thread sees object while it is being constructed #crazy_shit

not properly published object - object's field is not equal to its own reference (#crazier_shit) or stale data

Immutable objects and final fields can be used safely by any thread without additional synchronization, even when synchronization is not used to publish them. But if final fields refer to mutable objects, accessing them still requires synchronization.

Mutable objects must be safely published -> synchronization on publishing and consuming thread.

Properly constructed object can be safely published by:
 - initializing an object reference from a static initializer
 - storing a reference to it into a volatile field or AtomicReference; or
 - storing a reference to in into a final field of a properly constructed object; or
 - storing a reference to it into a field that is properly guarded by a lock

Thread-safe library collections safe publication guarantees:
 - placing a key or value in a Hashtable, synchronizedMap, ConcurrentMap safely publishes it to any thread that retrieves it from the Map
 - same for elements in Vector, CopyOnWriteArrayList, CopyOnWriteArraySet, synchronizedList and synchronizedSet [?] #the hell are those structures? :v
 - same for BlockingQueue or a ConcurrentLinkedQueue [?] 

Using a static initializer is often easiest and safest way to publish o bject that can be statically constructed.
-> JVM interal synchronization guarantees safe publication for static fields.

effectively immutable (objects) - technically not immutable, but state will not be modified after publication

Safely published effectively immutable objects can be used safely by any thread without additional synchronization.

If object may be modified after construction:
 - safe publication - ensure visibility of the as-published state
 - for publishing - synchronization
 - every access - synchronization - to ensure visiblity of subsequent modifications
 - sharing - must be thread-safe or guarded by lock

Publication requirements depends on object's immutability:
 - Immutable objects can be published through any mechanism
 - Effectively immutable objects must be safely published
 - Mutable objects must be safely published, and must thread-safe or guarded by a lock

Policies for using and sharing objects in a concurrant program:
 - Thread-confined - object owned exclusively by and confined to one thread and modified only by it
 - Shared read-only - can be accessed my many threads without synchronization just to read -> immutable / effectively immutable objects
 - Shared thread-safe - thread-safe object performs sync internally, many threads can access freely through public interface
 - Guarded - guarded object can be accessed onyl with a specific lock held. 










