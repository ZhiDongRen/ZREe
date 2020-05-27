% lab HMM - recognition with HMMs 

disp ('====== now recognizing !!! =======') 
format short e % this is to see correctly all elements of a vector

disp ('--------  test 1 versus models of 1, 2, 3, 4, 5 ----------');
Pvit1 = viterbi_log (c1t, A1, MI1, SIGMA1);
Pvit2 = viterbi_log (c1t, A2, MI2, SIGMA2);
Pvit3 = viterbi_log (c1t, A3, MI3, SIGMA3);
Pvit4 = viterbi_log (c1t, A4, MI4, SIGMA4);
Pvit5 = viterbi_log (c1t, A5, MI5, SIGMA5);
h=[Pvit1 Pvit2 Pvit3 Pvit4 Pvit5]
[nic,ii]=max(h); disp(['recognized ' num2str(ii) ]); pause

disp ('--------  test 2 versus models of 1, 2, 3, 4, 5 ----------');
Pvit1 = viterbi_log (c2t, A1, MI1, SIGMA1);
Pvit2 = viterbi_log (c2t, A2, MI2, SIGMA2);
Pvit3 = viterbi_log (c2t, A3, MI3, SIGMA3);
Pvit4 = viterbi_log (c2t, A4, MI4, SIGMA4);
Pvit5 = viterbi_log (c2t, A5, MI5, SIGMA5);
h=[Pvit1 Pvit2 Pvit3 Pvit4 Pvit5]
[nic,ii]=max(h); disp(['recognized ' num2str(ii) ]); pause

disp ('--------  test 3 versus models of 1, 2, 3, 4,5 ----------');
Pvit1 = viterbi_log (c3t, A1, MI1, SIGMA1);
Pvit2 = viterbi_log (c3t, A2, MI2, SIGMA2);
Pvit3 = viterbi_log (c3t, A3, MI3, SIGMA3);
Pvit4 = viterbi_log (c3t, A4, MI4, SIGMA4);
Pvit5 = viterbi_log (c3t, A5, MI5, SIGMA5);
h=[Pvit1 Pvit2 Pvit3 Pvit4 Pvit5]
[nic,ii]=max(h); disp(['recognized ' num2str(ii) ]); pause

disp ('--------  test 4 versus models of 1, 2, 3, 4, 5 ----------');
Pvit1 = viterbi_log (c4t, A1, MI1, SIGMA1);
Pvit2 = viterbi_log (c4t, A2, MI2, SIGMA2);
Pvit3 = viterbi_log (c4t, A3, MI3, SIGMA3);
Pvit4 = viterbi_log (c4t, A4, MI4, SIGMA4);
Pvit5 = viterbi_log (c4t, A5, MI5, SIGMA5);
h=[Pvit1 Pvit2 Pvit3 Pvit4 Pvit5]
[nic,ii]=max(h); disp(['recognized ' num2str(ii) ]); pause

disp ('--------  test 5 versus models of 1, 2, 3, 4, 5 ----------');
Pvit1 = viterbi_log (c5t, A1, MI1, SIGMA1);
Pvit2 = viterbi_log (c5t, A2, MI2, SIGMA2);
Pvit3 = viterbi_log (c5t, A3, MI3, SIGMA3);
Pvit4 = viterbi_log (c5t, A4, MI4, SIGMA4);
Pvit5 = viterbi_log (c5t, A5, MI5, SIGMA5);
h=[Pvit1 Pvit2 Pvit3 Pvit4 Pvit5]
[nic,ii]=max(h); disp(['recognized ' num2str(ii) ]); pause



