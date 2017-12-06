# Day 3

## --- Day 3: Spiral Memory ---

You come across an experimental new kind of memory stored on an infinite two-dimensional grid.

Each square on the grid is allocated in a spiral pattern starting at a location marked 1 and then counting up while spiraling outward. For example, the first few squares are allocated like this:

```
17  16  15  14  13
18   5   4   3  12
19   6   1   2  11
20   7   8   9  10
21  22  23---> ...

```

```
101 100 99  98  97  96  95  94  93  92  91  ||
102 65  64  63  62  61  60  59  58  57  90  ||
103 66  37  36  35  34  33  32  31  56  89  ||
104 67  38  17  16  15  14  13  30  55  88  ||
105 68  39  18   5   4   3  12  30  54  87  ||
106 69  40  19   6   1   2  11  29  53  86  ||
107 70  41  20   7   8   9  10  28  52  85  ||
108 71  42  21  22  23  25  26  27  51  84  ||
109 72  43  44  45  46  47  48  49  50  83  ||
110 73  74  75  76  77  78  79  80  81  82  ||
111 112 113 114 115 116 117 118 119 120 121 122
```
1 8 23 46 77 116
`101 65 37 17 5 1 9 26 49 81 122`
`91  57 31 13 3 1 7 21 43 73 111`

While this is very space-efficient (no squares are skipped), requested data must be carried back to square 1 (the location of the only access port for this memory system) by programs that can only move up, down, left, or right. They always take the shortest path: the Manhattan Distance between the location of the data and square 1.

```
For example:

    Data from square 1 is carried 0 steps, since it's at the access port.
    Data from square 12 is carried 3 steps, such as: down, left, left.
    Data from square 23 is carried only 2 steps: up twice.
    Data from square 1024 must be carried 31 steps.

```

### How many steps are required to carry the data from the square identified in your puzzle input all the way to the access port?

*Your puzzle input is `289326`.*
