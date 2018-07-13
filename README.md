# mdg-spending
My master's thesis project that studies the impact of UN MDG on US nonprofit industry spending. It was a collaboration between me and two other teammates. We worked together to narrow in on a research topic, identify data sources and eventually settle on a conceptual framework and subsequent empirical framework. I mostly worked on the statistical analyses part of the project: cleaning data, summary stats and regressions.

We have all since graduated and moved on to better things, but a perfectionist as I am, of course I wasn't happy with a long list of things in the study at the time. Now with more experiences in research and coding, hopefully something will come out of this pet project.

## research idea and background
The UN [Millennium Development Goals](https://en.wikipedia.org/wiki/Millennium_Development_Goals) (MDGs) were a set of eight goals published in 2000, aimed at eradicating extreme poverty, improving global health and education, promoting gender equality, etc. In 2015, they were replaced by the [Sustainable Development Goals](https://en.wikipedia.org/wiki/Sustainable_Development_Goals) (SDGs). At the time, all 191 countries of the UN committed to the MDGs, even though it was not a legally binding document. Given the nature of these goals, which mostly target poor countries and regions, it is likely that aids and projects were not directly delivered or initiated by governments of the mature economies, but partially led by international nonprofit organizations. We want to examine whether these goals affected American NGOs in their overall behaviors and outcomes: for those organizations whose missions align with the MDGs, did they get more donations and fundings, did they start spending more on their programs, or did nothing change?

## methodology
### diff-in-diff
### propensity score matching
In the early 2000s, technology has already started playing a more prominent role in designing and delivering aid. A closer look at this sector not only provides a fuller picture of international development and aid in the 21st century, but also serves as a robustness check to our research. I narrowed in on organizations in the tech sector. With a propensity score matching method, I can isolate a subset of tech organizations that closely match each other on characteristics such as asset, revenue and location. Step 2 adopts the same diff-in-diff analysis.

## data source
Since this was a master's degree thesis, we were able to purchase data with the help of our school [NYU Wagner School of Public Service](https://wagner.nyu.edu/). Our data come from the National Council of Charitable Statistics, which digitalized all United States 501(c)(3) nongovernmental organizations with gross annual receipts over $50,000, spanning from 1989 to 2014 with over six million firm-year observations, each identified by the NGO's Employer Identification Number (EIN) to track changes.

## preliminary outcome
You are welcome to read everything I have so far in the paper I uploaded, but it's quite long, so to give you a preview: yes there was an uptick in spending for those organizations whose mission align with the MDGs, and upon a closer look at the technology sector, the increase was even bigger.
