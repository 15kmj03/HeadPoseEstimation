diff=abs(X-beta);

A=X(:,1:5);
B=X(:,6:10);
C=X(:,11:15);

Adiff=diff(:,1:5);
Bdiff=diff(:,6:10);
Cdiff=diff(:,11:15);

gosa=[0,0,0,0,0,0,0,0,0];
hyoujunhensa=[0,0,0,0,0,0,0,0,0];

bi=A<-5;
gosa(1)=mean(Adiff(bi));
hyoujunhensa(1)=std(Adiff(bi));

bi=-5<=A&A<=5;
gosa(2)=mean(Adiff(bi));
hyoujunhensa(2)=std(Adiff(bi));

bi=5<A;
gosa(3)=mean(Adiff(bi));
hyoujunhensa(3)=std(Adiff(bi));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

bi=B<-5;
gosa(4)=mean(Bdiff(bi));
hyoujunhensa(4)=std(Bdiff(bi));

bi=-5<=B&B<=5;
gosa(5)=mean(Bdiff(bi));
hyoujunhensa(5)=std(Bdiff(bi));

bi=5<B;
gosa(6)=mean(Bdiff(bi));
hyoujunhensa(6)=std(Bdiff(bi));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

bi=C<-5;
gosa(7)=mean(Cdiff(bi));
hyoujunhensa(7)=std(Cdiff(bi));

bi=-5<=C&C<=5;
gosa(8)=mean(Cdiff(bi));
hyoujunhensa(8)=std(Cdiff(bi));

bi=5<C;
gosa(9)=mean(Cdiff(bi));
hyoujunhensa(9)=std(Cdiff(bi));

gosa
hyoujunhensa


