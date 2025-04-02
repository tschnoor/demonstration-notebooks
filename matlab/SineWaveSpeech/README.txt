README.txt

Instructions on Sine Wave Speech
At the matlab prompt type:

>>help SWS


To run the test case (sine wave version of "hawaii.wav")

1. load testcase.mat
2. [aud,b] = SWS(F,[],Fins,44100);
3. soundsc(aud,44100)

to listen to formants individually

for F1 type
>>soundsc(b(:,1))

for F2 type
>>soundsc(b(:,2))

for F3 type
>>soundsc(b(:,3))