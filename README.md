# hashcatformat
Pipe --quiet hashcat output into hashcatformat to receive sane username:pass output (less hash)

## Supported formats
More added as they're encountered, or feel free to add more of your own and submit a pull request.

## Usage

First, identify your hash
```
┌──(notroot㉿elysium)-[/tmp]
└─$ hashcat --identify rita_hash.txt 
The following hash-mode match the structure of your input hash:

      # | Name                                                       | Category
  ======+============================================================+======================================
  13100 | Kerberos 5, etype 23, TGS-REP                              | Network Protocol
```
^^ maybe you just learn a protip?  Cheers and big ups your game mate


Then crack the motherfather in quiet mode, piping to hashcatformat:
```
┌──(notroot㉿elysium)-[/tmp]
└─$ hashcat -m 13100 rita_hash.txt /usr/share/wordlists/rockyou.txt --force --quiet| ~/repos/hashcatformat/hashcatformat.sh -m 13100
CAPONE.SLANTED.LOCAL\Rita:Contoso321Go!
```

Already cracked hashes on a given hash file (hashes.txt)?  No problem, be a bigboi and pipe show crackpot through hashcatformat:
```
┌──(notroot㉿elysium)-[/tmp]
└─$ hashcat -m 13100 hashes.txt --show | ~/repos/hashcatformat/hashcatformat.sh -m 13100
CAPONE.SLANTED.LOCAL\Rita:Contoso321Go!
CAPONE.SLANTED.LOCAL\Gustav:Ch3rryp1ck3r20ft#
SLANTED.LOCAL\Uncle.Barry:Megreencuub3*@*@
```