+++
title = 'Heisenbugs'
date = 2024-06-27T11:10:57+02:00
draft = true
excerpt = "Strangest Bugs"
+++

Recently I saw a video about [the Weirdest Linux Bug Ever Discovered](https://www.youtube.com/watch?v=-6fPfwixNLk). 
In short, the problem is that printing was not possible in some cases. At first it wasn't entirely clear what the 
problem could be. A driver? The software? The printer? The problem here was that the error did not seem to be 
reproducible. Sometimes printing worked, sometimes it didn't.

## "Hey Dev, can you help me with the printer?"
Since several users had the same problem, it _had_ to be a bug. However, it was not reliably reproducible.
At least not at first glance. The wife of a developer came across a first clue, apparently by chance: the problems only
occurred on a Tuesday. This is typically the moment that electrifies every developer. 
Progress! A narrowing-down of the chain of events. A reproducible error. 
As we all know, this is the first (and most important) step in fixing a bug.

What the video did get me to do, however, is to write about how difficult it can be to identify bugs. Bugs that are 
difficult (or impossible) to reproduce are sometimes called **Heisenbugs**. I like that term.

## So what is a Heisenbug?
According to [Wikipedia](https://en.wikipedia.org/wiki/Heisenbug), a heisenbug is 
> a software bug that seems to disappear or alter its behavior when one attempts to study it. The term is a pun on the name of Werner Heisenberg,

Even though I love debugging, these are the most difficult bugs of all. Bug fixing in agile teams is a whole other 
story anyway, but these can at least be roughly estimated ("_The invoice number is not being forwarded to the payment interface? No problem, I know where to look_").

So, you grab the bug ticket. But as soon as the bug doesn't appear again, you have a problem. Before you even get around
to investigating the error, you need to know how to reproduce it: What could the user have done? What events could have
led to the error message? Are there certain patterns when analyzing the error logs?

You can invest hours, days or even weeks investigating a bug. By the third standup in a row, you'll be embarrassed to 
say that you haven't made any progress in fixing the bug. So what should you do? You (and your team) come to the 
conclusion that the ticket needs to be closed. Jira has such cute labels for this: `Won't Fix` or `Can't reproduce`.

But a bug that you can't solve is still a bug. Your team wouldn't discover it in the next few days, but it's only a 
matter of time before the next user reports the problem. And every dissatisfied user is one too many. Personally, it 
really bothers me (even after work) - knowing that there's still a bug out there waiting to be fixed. How nice must that
moment be when you've identified the problem?

No, your own ambition demands that you try again for the ticket!

## Heisenbugs doesn't need a regular developer - they needs a detective.
So you've seen the error message in the error log for the umpteenth time. The backtrace is meaningless and you're at 
your wits' end. Of course, there is no recipe for preventing these types of bugs. But it can help to consider a few 
points before you lose your nerves.

### Be an Investigator 
Document everything you know! Go through all the tickets that have a similar bug description. Write down the 
similarities. Also note unimportant things (like _when_ the bug occurred). Find a way to visualize similarities and 
eliminate differences in related tickets.
Try to see if you can recognize certain patterns that could help you reproduce the bug, for example
- Was it always the same time of day?
- Did the error occur with a certain browser?
- Was it the same user each time?
- Was the user able to reproduce the problem themselves?
- If so, how is their setup/configuration different from yours?

### Try not to be the user, not the developer
Is it possible that the Bug is limited to a certain group of users? Congratulations, the Heisenbug is almost history.

Even if it is never 100% possible, try to be as close to the user's environment as possible. 
Ideally, the user who caused the error. Again, it depends on the details - maybe a certain account balance is causing 
the error? Maybe the profile picture has a special format? 
Maybe they are using real credit card data, while you only use sample numbers in your development environment? Is 
an installed ad blocker causing scripts to fail to load? Is a backend process possibly different because the user is in
a different time zone? Was the customer's data set created at a different time, which is why the same logic is not
being executed in the code? Try to take every detail into account. It helps to think destructively:
Don't think "What detail is different for the user?" Think "What is the smallest possible setting that is different for the user than mine?"

### Take advantage of the bird's eye view
If the problem cannot be traced back to a specific entity (e.g. User group, device etc), try to gain a bird's eye view.

Identify other patterns or similarities that can narrow down the problem. Don't forget that context that are hard to simulate:
- Does the bug only appear at certain times of the day?
- Does the problem perhaps only occur after a certain sequence of events? This refers to events that occurred long before the actual error (and about which backtraces can no longer provide information)
- Does the bug only occur in a certain combination of events? I heard a story from a former team member where a certain bug only occurred when he used the app on two devices at the same time, had 2FA enabled, a certain time zone was selected and a profile picture was uploaded.
- Consider Hardware effects during the buggy operation too: What about the network performance? What was the CPU or memory load like on server (and client)?

### Use the Logging, Luke
Sometimes a clue is enough. A crumb of knowledge that is thrown at you as a detective, which means that you can perhaps 
guess in which area of the software the error could occur. 

A supervisor once gave me the advice "Log every fart the customer makes".

This is where logging can work for you. Log everything you can get. Log even if you think you know the value. Question 
everything. But good logging is the be-all and end-all for fighting Heisenbugs. Good logging is like a trap just waiting
to snap shut.

This is especially important psychologically: You know that you are prepared for the next event. You no longer have to 
worry that the customer will report the same error again. You look forward instead to the next occurrence of the bug 
because in this case you will get more background information.

Another advantage of more intensive logging is that you can present progress to your team: 

> "I need more information to reproduce the error, so I created a PR that will provide us with more information in the future"


sounds better than 
> "I tried to reproduce the error today, but without success"


## Instruct your team
Speaking of which, communication with the team is not to be underestimated:
Not being able to fix a bug can cause real stress for some developers. Not just from a personal perspective, but also 
from a professional one. Help yourself and take the bull by the horns.

Talk to colleagues about your previous attempts to find the error. Communication creates trust. Getting an understanding
from your colleagues helps you to approach the error search more calmly and consciously. Communication with your team
has another advantage here that is often underestimated: you can use the knowledge of other developers. 

Every detail could be important in identifying or reproducing the error. Talk to colleagues and go into detail. In my
career, there have often been conversations that follow this pattern:

> **A:** _I've been trying for two hours to figure out why the correct amount isn't being sent to the payment service provider._

> **B:** _Phew, unfortunately I have no idea about that either_

> **A:** _I'm really at my wits end. Interestingly, the amount is only transferred incorrectly when the currency is CHF._

> **B:** _Ah, Simon also had a problem with the conversion library recently, and only with Swiss francs. Why don't you talk to him?_

Often, new approaches emerge seemingly by chance, just because you have explained a particular misbehavior in more detail.