function [DSC, I, res] = DiceScore(Iin, GT)

AIin = sum(sum(Iin));
AGT = sum(sum(GT));

I = Iin & GT;

Acom = sum(sum(I));
%Ares = (AIin | AGT);
%resT = 2*(Iin | GT) - I;
resT = 2*abs((Iin - I ))+ abs((GT - I));
res = label2rgb(resT);

DSC = 2*Acom / (AIin + AGT);

%sprintf('Area: GT: %f  Iin: %f com: %f  DSC: %f', AGT, AIin, Acom, DSC)
