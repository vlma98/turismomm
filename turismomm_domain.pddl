(define (domain turismomm)
    (:requirements :strips)
    (:predicates
        (adj ?where1 ?where2)
        (at ?what ?where)
        (walkable ?from ?to)
        (is-turist ?who)
        (is-bike ?what)
        (is-bike-station ?where)
        (is-turistic-point ?where)
        (have ?who ?what)
        (have-to-wait ?who)
        (waited ?who)
        (have-to-deliver ?who ?what)
        (visited ?who ?where)
        (have-a-bike ?who)
        (need-money ?where)
        (have-money ?who)
        (money-in ?where))
    
    (:action take-bike
        :parameters (?who ?what ?where)
        :precondition (and (is-turist ?who)
                      (is-bike ?what)
                      (is-bike-station ?where)
                      (at ?who ?where)
                      (at ?what ?where)
                      (waited ?who)
                      (not (have-a-bike ?who))
                      )
        :effect (and (have ?who ?what)
                (not (at ?what ?where))
                (have-a-bike ?who))
    )
    (:action deliver-bike
        :parameters (?who ?what ?where)
        :precondition (and (is-turist ?who)
                      (is-bike ?what)
                      (is-bike-station ?where)
                      (have ?who ?what)
                      (at ?who ?where)
                      (have-to-deliver ?who ?what))
        :effect (and (at ?what ?where)
                (at ?who ?where)
                (not (have ?who ?what))
                (not (have-to-deliver ?who ?what))
                (not (have-a-bike ?who))
                (have-to-wait ?who))
    )
    (:action wait-5minutes
        :parameters (?who)
        :precondition (and (is-turist ?who)
                      (have-to-wait ?who)
                      (not (have-a-bike ?who))
                      )
        :effect(and (waited ?who)
               (not (have-to-wait ?who)))
    )
    (:action walk
        :parameters (?who ?from ?to)
        :precondition (and (is-turist ?who)
                      (at ?who ?from)  
                      (walkable ?from ?to)
                      (not (have-a-bike ?who)))
        :effect (and (not (at ?who ?from))
                (at ?who ?to))
    )
    (:action visit-point
        :parameters (?who ?where)
        :precondition (and (is-turist ?who)
                      (is-turistic-point ?where)
                      (at ?who ?where)
                      (or (not (need-money ?where))
                        (and (need-money ?where) (have-money ?who)))
                      )
        :effect (and (visited ?who ?where) 
                     (not (have-to-wait ?who))
                     (waited ?who)
                     (when (money-in ?where) (have-money ?who))
                )                 
    )
    (:action ride
        :parameters (?who ?from ?to ?what)
        :precondition (and (is-turist ?who)
                           (is-bike-station ?from)
                           (is-bike-station ?to)
                           (is-bike ?what)
                           (have ?who ?what)
                           (adj ?from ?to)
                           (at ?who ?from)
                           (not (have-to-wait ?who))
                           (not (have-to-deliver ?who ?what)))
        :effect (and (not (at ?who ?from))
                     (at ?who ?to)
                     (at ?what ?to)
                     (have-to-deliver ?who ?what)
                     (have-to-wait ?who))

    )
)