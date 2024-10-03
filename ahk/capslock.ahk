; SwapKeyでCapsLockをF21にしている
F21 & b::Send "{Left}"
F21 & f::Send "{Right}"
F21 & n::Send "{Down}"
F21 & p::Send "{Up}"
F21 & a::Send "{Home}"
F21 & e::Send "{End}"
F21 & d::Send "{Del}"
F21 & h::Send "{BS}"
F21 & m::Send "{Enter}"
F21 & k::{
  Send "{ShiftDown}{END}{ShiftUp}"
  Sleep 20 ;[ms] this value depends on your environment
  Send "{Del}"
  return
}

F21 & o::^o
F21 & s::^s
F21 & c::^c
F21 & i::^i
F21 & r::^r
F21 & l::^l
F21 & v::^v
F21 & w::^w
