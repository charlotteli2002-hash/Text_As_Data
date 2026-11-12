# L2 score generation:
Confusion matrix:
[[1915   73]
 [ 162 1776]]

Classification report:
              precision    recall  f1-score   support

           0       0.92      0.96      0.94      1988
           1       0.96      0.92      0.94      1938

    accuracy                           0.94      3926
   macro avg       0.94      0.94      0.94      3926
weighted avg       0.94      0.94      0.94      3926

ROC AUC: 0.987

Sparsity diagnostic: 16111 of 16111 coefficients are non-zero (100.0% non-zero, 0.0% zero)

Top 15 positive-weight words (most predictive of CORE = 1):
  trade                +27.5931
  merchants            +22.1591
  merchant             +17.5480
  marchants            +13.2946
  marchant             +9.0986
  factor               +5.2837
  staple               +4.9053
  commodities          +3.9511
  goods                +3.2486
  chapman              +3.2466
  buy                  +2.9229
  ships                +2.8778
  adventurers          +2.7163
  ship                 +2.6875
  gaine                +2.6443

Top 15 negative-weight words (most predictive of NEG = 0):
  god                  -2.7626
  christ               -1.7839
  rome                 -1.7292
  power                -1.7179
  pope                 -1.6912
  forces               -1.5738
  spirit               -1.5737
  enemies              -1.5454
  vertue               -1.5160
  that                 -1.5109
  faith                -1.4783
  battaile             -1.4489
  gods                 -1.4227
  lib                  -1.4029
  were                 -1.3508

False positives (true NEG, predicted CORE): 73 total, showing 5

[FP] index=84  P(core)=0.515
being of an huge bignesse, and very stately built, being of marueilous force also, and so high, that they resembled great castles, most fit to defend themselues and to withstand any assault, but in giuing any other ships the encounter farre inferiour vnto the English and Dutch ships, which can with great dexteritie weild and turne themselues at all assayes. The vpperworke of the said Galeons was of thicknesse and strength sufficient to beare off musket-shot.

[FP] index=151  P(core)=0.506
Zurech hath a peculiar Counsell, which may be called the Exchequer Court, consisting of eight men, chosen foure out of each Senate, and to them all Exchequer accounts are referred. Two Clerkes or Secretaries are present at publike Counsels, with assistants ioyned to them if neede require; and the Office of these Secretaries, especially of the chiefe, is honourable and gainefull, and not easily conferred on any but a Patritian, because they must haue full knowledge of the Lawes, Customes, Priuiledges, and all secrets of the Common-wealth.

[FP] index=163  P(core)=0.515
So as, being one time there (whereby you shall easily gather how ignorant these sage Magni∣fico's were in the artfull profession of the pipe) it was my fortune to consort with a joviall fri of young Pupills, all Fresh∣men save one or two, who had received seasoning from the Pump for their ab∣surdities. With whom having traversed two or three pipes of rich Varina, with some bottles from Fons.

[FP] index=249  P(core)=0.596
Thirdly, it will be a meanes for vs to reape the rest of the commodities of that Countrey, which 3 now we cannot enioy for want of people to looke after them, and also for want of leasure, our men there being busied in the Summer about the fish∣ing, or in preparing of their stages and boats, and afterward returning home against winter. The commodities of the Land are Furres of Beuer, Sables, Blacke Foxes, Marternes, Musk-rats, Ot∣ters, and such like skinnes, as also of greater beasts; as Deere, and other wild creatures.

[FP] index=369  P(core)=0.645
But for as much as Siluer is found in the lead Mines, and that the siluer Mines haue their Ores mixt with hard lead also, it happeneth many times, that there are great questions about these Mines, when Princes will claime their interest in some lead Mines, because they are rich in siluer: as of late yeares betweene Queene Elizabeth and the Earle of Northumberland, as you may read in Master Plowdens Commentarie of Booke Cases, where it was adiudged, That if a Mine be found richer in siluer of more value within the Ore, than of lead, all charges of the working of both mettalls being fully paied; the Prince may claime the same to be a Mine Royal: wherein must be had great aduisement, some Ore in one place being richer than other Ore in another place of the same Mine, whereof we may handle in his proper place of other Mines.

False negatives (true CORE, predicted NEG): 162 total, showing 5

[FN] index=30  P(core)=0.499
This was e'ne as I would haue it, it hit as pat as a pudding to a Fryers mouth, I could not haue wisht it to haue falne out better; for I had already be∣gun to deuise and cast with my selfe, to whom, or how I might sell it, and what chapman I might best finde out to buy it of mee; for if they should come to scanne my person, they might easily be induced to beleeue, that I had stolne it.

[FN] index=44  P(core)=0.441
How now Shylocke, what newes among the Merchants? Enter Shylocke. Shy. You knew none so well, none so well as you, of my daughters flight. Sal. That's certaine, I for my part knew the Tailor that made the wings she flew withall. Sol. And Shylocke for his own part knew the bird was fledg'd, and then it is the complexion of them al to leaue the dam. Shy. She is damn'd for it. Sal. That's certaine, if the diuell may be her Iudge. Shy. My owne flesh and blood to rebell. Sol. Out vpon it old carrion, rebels it at these yeeres. Shy. I say my daughter is my flesh and bloud. Sal.

[FN] index=53  P(core)=0.377
And with the odour of this incense, she is comforted; according to the Proverbe, Ointment and perfume rejoyce the heart, Prov. 27. 9. and frankincense] Myrrh was used in the holy anointing oile; and frankincense in the sweet perfume, Exod. 30. which perfume fi∣gured the mediation of Christ, the Angell which offereth much incense w ch the prayers of all saints, Rev. 8. 3. So through his death and intercession the Church hath her sweet smell: and all her gar∣ments are Myrrh, aloes and Cassia, Psal. 45. with all powder] or, above all powder (that is powders or spices) of the Merchant. That is, with all other graces that Christ hath bestowed upon her by the preaching of his Gospell.

[FN] index=75  P(core)=0.440
Ercembaldus dedit Ecelesiae Sanctae Mariae d^mum suam, cum Cappella sua de Sancto Christophero, and villam suam de Christolio super Matronam, ita tamen vt in dicta sua Cappella de sancto Christophero nullus inhumaret^r nisi sit de linea, and Familia sua. By meanes of this donation, the Foundations of this Mother Church, Mauris Ecclesiae, were by the said Robert laid further on this side, to the end, of being neerer to the great Bridge of Paris, where heretofore (according to the testimonie of S. Gregory of Tours, in his Historie of France, and namely, in the time of Saint Lewes (as saith the Lord of Ioinuille in his life) dwelt the Merchants of Silkes, or Mercers, Goldsmiths, Iewellers, and Money-Bankers of Paris.

[FN] index=86  P(core)=0.402
For when no male issue royall was left, these Princes agreed, That meeting in a place appointed, he whose Horse first neighed, should be acknowledged Emperour. Darius his Horse-keeper, the night be∣fore, had suffered his Horse there to vse his bruitish lust with a Mate; which the place presently causing him to remember, he there (by his lustfull neighing) aduaunced his Master to the Scepter. Darius for his couetousnesse (first exacting tribute) was called a Marchant, Cambyses a Lord, Cyrus a Father of his people. Babylon rebelled, and was 3436. recouered by the costly stratageme of Zopyrus Iustin.l. . Plutarch. in Apophibeg.

# L1 evaluation
Confusion matrix:
[[1988    0]
 [  14 1924]]

Classification report:
              precision    recall  f1-score   support

           0       0.99      1.00      1.00      1988
           1       1.00      0.99      1.00      1938

    accuracy                           1.00      3926
   macro avg       1.00      1.00      1.00      3926
weighted avg       1.00      1.00      1.00      3926

ROC AUC: 0.999

Sparsity diagnostic: 32 of 16111 coefficients are non-zero (0.2% non-zero, 99.8% zero)

Top 15 positive-weight words (most predictive of CORE = 1):
  trade                +176.5027
  merchants            +148.9919
  merchant             +123.1699
  marchants            +90.8471
  marchant             +68.0220
  staple               +57.5953
  factor               +56.4201
  adventurers          +41.8150
  chapman              +36.8570
  adventurer           +30.4520
  purser               +27.3006
  ship                 +2.7029
  have                 +2.4793
  william              +1.7110
  sir                  +1.3678

Top 15 negative-weight words (most predictive of NEG = 0):
  that                 -2.4497
  god                  -2.2699
  it                   -0.9004
  not                  -0.6335
  was                  -0.4679
  his                  -0.3423
  he                   -0.0376
  him                  -0.0046

False negatives (true CORE, predicted NEG): 14 total, showing 10

[FN] index=107  P(core)=0.469
The nineteenth sorte of Ling was Fumb-LING, which is for their dyets who haue beene long maried and can get no children. The twenteeth was Ming-LING, which was for Wine-marchants, Vintners, Brewers, and Apothecaries. Iumb-LING and Tumb-LING, for the keepers and Cupid an haunters of vaul∣ting houses. Fid LING, Fud-LING, and Stumb-LING from the Schooles of Dauncing, and Drinking. The twenty sixt sorte of Ling was Bung LING, which was the fare of Quack-s l∣u r , Mountebanckes Ratcatching Waterca∣sters, and also for all bo hing Artificers and cobling Trades-men. Mumb-LING was for those that had no need of the Tooth-drawer. Ster-LING money was at such a Scant-LING, Why these Ships are called SHIPS.

[FN] index=177  P(core)=0.018
And in calmes or fayre wea∣ther they must passe euery flie-bore, at least euery Fleet they send out and receiue home, with a guard suffi∣cient to keepe vs vnder hatches; otherwise wee shall be sure to gaine more by their voyages, then they them∣selues that are the venturers. Now how impossible it is for that State o preuent these disasters of theirs, and aduantages of ours, is apparent to any man that obser∣ueth the situation of their Coast and ours.

[FN] index=300  P(core)=0.432
print 1602. by Samuel mace of weymouth in march one thousand six hundred and two but he and the former perform nothing but return with frivolous allegation the same year captain Bartholomew gosnold and captain Gilbert the north part of Virginia of which voyage John brereton c c John brereton have write a treatise and in the year one thousand six hundred and five captain George waymouth make thither a prosperous voyage and discover threescore mile up a most excellent river his voyage be set forthin print by james d d james rosier rosier after this follow the plantation by the present adventurer in the year one thousand six hundred and six e e Relat. cap. Smith m.s. and w.s.

[FN] index=418  P(core)=0.018
The greene L very, that Embleme of frailtie, which h e wore living, must now bee the Carp t t cover him dying. Out of all hi spacious raunge, he ha's rese ved so much ground a may afford him a Grave. More hee n edes not, and to bee debarr d t is, even in humanity he can ot. What rests then, but that hee rest after his long Walke? While a fixe his owne Epitaph upon his owne naked monume t, to make his memory more perp tuate; Defessus sum ambulando. Pitty were it then to disquiet him. 7. A Gamester IS a Merch t-venturer, for his stocke ru nes alwaies upon ha∣zard.

[FN] index=628  P(core)=0.449
Gal. Tis worse, tis worse. Maist. Gal. My factor broke, or is the Ionas suncke. Mist. Gal. Would all we had were swallowed in the waues,
Rather then both should be the scorne of slaues. Maist. Gal. I'me at my wits end. Mist. Gal. Oh my deere husband,
Where once I thought my selfe a fixed starre,
Plac't onely in the heauen of thine armes,
I feare now I shall proue a wanderer,
Oh Laxton, Laxton, is it then my fate
To be by thee orethrowne? Maist. Gal. Defend me wisedome,
From falling into frenzie, on my knees. (thy bosome. Sweete Pru, speake, whats that Laxton who so heauy lyes on Mist. Gal. I shall sure run mad. Maist. Gal.

[FN] index=1882  P(core)=0.254
Cliffords Inne in Fleetstreet, Thavies Inne in Oldborne, Furnevals Inne in Oldborne, Barnards Inne in Oldborne, Staple Inne in Oldborne, Without the Liberties. Houses of Court. Grayes Inne in Oldborne, Lincolnes Inne in Chancerie∣lane, by the old Temple. Houses of Chancerie without Temple barre, in the liberty of Westminster. Clements Inne, New Inne, Lions Iune, There was sometime an Inne of Ser∣geants in Oldborne, A Serge∣ants Inne in Oldborne as ye may reade of Scroopes Inne, over against Saint An∣drews Church. There was also one other Inne of Chan∣cerie, Chesters Inne, or Strand Inne, in place whereas standeth Sommerset House.

[FN] index=2459  P(core)=0.023
First, they goe with lesse charge then others both for men and victualls. Their ships requiring fewer per∣sons to man them, and their men lesse victuall and courser to keepe them, then ours. Besides, many of them are venturers, and so sharers in the gaine: And therefore wilbe content to liue vvith little, to indure all difficulties, to vvorke out all hazards with pati∣ence, and bee good husbands for the generall, whilst they know the profit redounds to their particulars. 2.

[FN] index=2633  P(core)=0.030
But if there shall not bee Clothiers enow found in the same Towne of Newbury, to enjoy this loane in manner as aforesaid; then the same money shall bee lent also unto other Tradesmen, free of the same Towne, by the summes and termes of yeeres last before appointed, to such as set most poore people on worke, according to the discretion of the said Maior, Alder∣men and Burgesses; to whom this said five hundred pounds shall bee paid, to the use aforesaid, at the end of one yeere after my decease. Item, Nine hundred pounds given to the Mer∣chant Ad∣venturers.

[FN] index=2635  P(core)=0.023
who thereby are inable to keep this discommodity on foot by bribes; especially so many great persons (even States∣men) being venturers and sharers in the gaine. Besides this wasteth their Mariners, not one of ten returning. Which I am glad to heare, for they are the men vve stand in feare of. 3. As for their West indian voyages, I withstand them in earnst because they begin to inhabit there and to fortifie them∣selves; and may in tyme there perhaps raise an other England to withstand our new Spaine in America, as this old England opposeth our present State, and cloudes the glorious extent therof in Europe.

[FN] index=2711  P(core)=0.020
Now a Franck gale of winde goe with him, Maister Franke, we haue too few such knight aduenturers: who would not sell away competent certainties, to purchase (with any danger) excellent vncertainties? your true knight venturer euer does it. Let his wife seale to day, he shall haue his money to day. Qui.