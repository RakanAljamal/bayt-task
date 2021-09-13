#! /bin/env tclsh

proc isNumber {val} {
    return [string is double -strict $val]
}

proc isOdd {val} {
    return [expr int($val) % 2 != 0]
}

proc isFloat {float} {
    return [expr abs($float - int($float)) > 0 ? 1 : 0]
}

proc isAllowed {val} {

    regexp {(^[A-Za-z0-9])} "$val" match
    set code [catch {
        set err $match
    } result]

    return [expr !$code]
}

set numbers {}
set oddNumbers {}
set evenNumbers {}
set strs {}
set linesSize {}
set invalidLines {}


set fp [open "input.txt" r]

while { [gets $fp data] >= 0 } {
    lappend linesSize [string length [string trim $data]]

    if {[isNumber $data] && ![isFloat $data]} {

        if {[isOdd $data]} {
            puts [expr $data / 2.0]
            lappend oddNumbers $data
        } else  {
            puts [expr $data * 3.25]
            lappend evenNumbers $data

        }

        lappend numbers $data

    } else {
        
        if {![isAllowed $data]} {
            puts "INVALID LINE"
            lappend invalidLines $data
            continue
        }
        puts $data

        if {[string trim $data] != ""} {
            lappend strs $data
        }

    }



}
close $fp
set max [tcl::mathfunc::max {*}$numbers]
set min [tcl::mathfunc::min {*}$numbers]


if {[llength $numbers] >= 2} {

    set x [lindex $numbers 0]
    set y [lindex $numbers 1]

    puts "\n \nThe sum of the first two numbers are  [expr $x + $y ] \n"
}

if {[llength $strs] >= 3} {

    set str1 [lindex $strs 0]
    set str2 [lindex $strs 1]
    set str3 [lindex $strs 2]

    puts "concatinating first 3 lines starting with the string $str1$str2$str3 \n"
}


puts "Printing Line sizes \n----------------------"
set lineIndex 0
foreach number $linesSize {
    puts "Line [expr $lineIndex + 1]:  $number"
    incr lineIndex
}

puts "----------------------\n"

puts "\n \nMinimum number is $min \nMaximum number is $max"



puts "\n \nGenerating report : "


puts "####################################################"

puts "Invalid lines found: [llength $invalidLines]"
puts "Odd numbers found: [llength $oddNumbers]"
puts "Even numbers found: [llength $evenNumbers]"
puts "Strings found: [llength $strs]"

puts "####################################################"