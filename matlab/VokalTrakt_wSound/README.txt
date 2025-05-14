README.txt for "MakeTwoVowels.m"
    
   
 Run MakeTwoVowels.m with the following command:
 
 >>[aud1,aud2,audC] = MakeTwoVowels(vow1,vow2,F0);
 
 where vow1 and vow2 are the numerical indices of one of ten vowels.
 
 vowel code: 
 1='ii' as in 'heat'
 2 = 'ih' as in 'hit' 
 3='eh' as in 'head'
 4='ae' as in 'hat'
 5='ah' as in 'hut'
 6='aa' as in 'hot'
 7='aw' as in 'haw'
 8='oo' as in 'hope'
 9='uh' as in 'hood'
 10 = 'uu' as in 'who'
 
 F0 = fundamental frequency in Hz
 
 Outputs: aud1 = vowel 1; aud2 = vowel2; audC = combined vowels 1 and 2
 
 Example call for an /a/ vowel followed by /i/ and F0 = 150 Hz:  
 
 >> [aud1,aud2,audC] = MakeTwoVowels(6,1,150);
 
 NOTE: This function automatically writes three .wav files called:
 
 vow1.wav    This is the first vowel alone - 500 ms
 vow2.wav    This is the second vowel alone - 500 ms
 vow1vow2.wav  This is the concatenation of the first and second vowels 1000 ms
 
 vow1 and vow2 should have exactly the same RMS amplitude. You should verify this by reading them into praat 
 checking the intensity line in the Edit window.
 
 Once you run a set of vowels change the file names to something you want to keep. The next time you run 
 MakeTwoVowels.m a new set of vow1.wav, vow2.wav, vow1vow2.wav files will be written.
