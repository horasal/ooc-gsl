use ooc-gsl
import matrix
import math/Random

v := Vector new(10)
for(i in 0..v size()){
    v[i] = Random randInt(0,100) * 1.0 as Double
}


v2 := Vector new(10)
for(i in 0..v2 size()){
    v2[i] = Random randInt(0,100) * 1.0 as Double
}

v toString() println()
v2 toString() println()

// memory leak, because we alloced a new vector
(v * v2) toString() println()

v free()
v2 free()
