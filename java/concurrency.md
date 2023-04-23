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




