      subroutine uhyper(bi1,bi2,aj,u,ui1,ui2,ui3,temp,noel,
     .                 cmname,incmpflag,numstatev,statev,
     .                 numfieldv,fieldv,fieldvinc,numprops,props)

      include 'aba_param.inc'

      character*8 cmname
      dimension ui1(3),ui2(6),ui3(6),statev(*),fieldv(*),
     .          fieldvinc(*),props(*)
c
      c10 = props(1)

c
      statev(1) = bi1
      statev(2) = bi2
c
      u = c10*(statev(1)-3.)
      ui1(1) = c10
      ui1(2) = 0.
      ui1(3) = 0.
      ui2(1) = 0.
      ui2(2) = 0.
      ui2(3) = 0.
      ui2(4) = 0.
      ui2(5) = 0.
      ui2(6) = 0.
      ui3(1) = 0.
      ui3(2) = 0.
      ui3(3) = 0.
      ui3(4) = 0.
      ui3(5) = 0.
      ui3(6) = 0.

      return
      end
