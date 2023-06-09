> https://adventofcode.com/2020/day/2

Nothing much to say, simple regex-friendly task.

> https://adventofcode.com/2020/day/1

Keeping three pointers - requires whole list in memory and sorting.
In general, sorting requires whole input in memory. No likey.

Just keep collection of seen numbers and iterate over input, checking each time, if remainder can be composed from seen numbers.

```
def solution_two():
    file = open("input.txt", "r")

    seen_numbers = set()
    for line in file:
        value = int(line)
        remaining = 2020 - value

        for number in seen_numbers:
            if remaining < number:
                continue
            remaining_in_seen = remaining - number

            if remaining_in_seen in seen_numbers:
                result = [value, number, remaining_in_seen]
                print(result)
                print(value * number * remaining_in_seen)
                return result

        seen_numbers.add(value)
```
