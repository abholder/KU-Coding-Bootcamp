

```python
# 3 Observable Trendsn (based on results ran on 4/26/18 @ approx 6:30pm): 
# --------------------
# 1. If there is such a thing as "fake news", then all of the selected news organizations are reporting it;
#     the numbers are too similar
# 2. Republicans like to say there is a media bias while Democrats typically deny that; 
#     it surprises me that Fox News is closest to neutral... maybe there is a left-leaning media bias?
# 3. BBC has always struck me as the most impartial news outlet, probably because they are a foreign outlet
#     so why would they be biased? But they are actually the most negative of the selected news organizations.
#     I wonder if this is typical or due to the current administration; nothing seems "normal" this past year
#     in politics.
```


```python
# Dependencies
import tweepy
import json
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.patches as mpatches
import time
import pprint

from vaderSentiment.vaderSentiment import SentimentIntensityAnalyzer
analyzer = SentimentIntensityAnalyzer()

from textblob import TextBlob

# styling for plots
plt.style.use("seaborn")

from config import consumer_key, consumer_secret, access_token, access_token_secret

# Setup Tweepy API Authentication
auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)
api = tweepy.API(auth, parser=tweepy.parsers.JSONParser())
```


```python
# build list for target users
target_terms = ("@BBCWorld", "@CBSNews", "@CNN",
                "@FoxNews", "@nytimes")
```


```python
# List to hold results
results_list = []

# Variables for holding sentiments
compound_list = []
positive_list = []
negative_list = []
neutral_list = []

# holding tweet info
tweet_source = []
tweet_text = []
tweet_date = []
counter = []


# Loop through all target users
for target in target_terms:

    # Variable for holding the oldest tweet
    oldest_tweet = None
    
    #counter
    y = 0

    # Loop through 10 times
    for x in range(5):

        # Run search around each tweet
        public_tweets = api.user_timeline(
            target, max_id=oldest_tweet, page=x)

        # Loop through all tweets
        for tweet in public_tweets:
            
            y = y+1
            
            # Run Vader Analysis on each tweet
            compound = analyzer.polarity_scores(tweet["text"])["compound"]
            pos = analyzer.polarity_scores(tweet["text"])["pos"]
            neu = analyzer.polarity_scores(tweet["text"])["neu"]
            neg = analyzer.polarity_scores(tweet["text"])["neg"]

            # Add each value to the appropriate list
            compound_list.append(compound)
            positive_list.append(pos)
            negative_list.append(neg)
            neutral_list.append(neu)
            tweet_source.append(tweet["user"]["name"])
            tweet_date.append(tweet["created_at"])
            tweet_text.append(tweet["text"])
            counter.append(y)

        # Set the new oldest_tweet value
        oldest_tweet = tweet["id"] - 1
    
```


```python
news_df = pd.DataFrame({"Compound": compound_list, "Positive": positive_list, 
                        "Negative": negative_list, "Neutral": neutral_list, "Tweet Source": tweet_source,
                        "Tweet Date": tweet_date, "Tweet Text": tweet_text, "Tweets Ago": counter})
news_df
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Compound</th>
      <th>Negative</th>
      <th>Neutral</th>
      <th>Positive</th>
      <th>Tweet Date</th>
      <th>Tweet Source</th>
      <th>Tweet Text</th>
      <th>Tweets Ago</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>0.0000</td>
      <td>0.000</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>Sun Apr 29 01:34:30 +0000 2018</td>
      <td>BBC News (World)</td>
      <td>Trump says US-North Korea summit may be 'in th...</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1</th>
      <td>-0.5423</td>
      <td>0.304</td>
      <td>0.696</td>
      <td>0.000</td>
      <td>Sun Apr 29 01:25:16 +0000 2018</td>
      <td>BBC News (World)</td>
      <td>#MeToo: Why sexual harassment is a reality in ...</td>
      <td>2</td>
    </tr>
    <tr>
      <th>2</th>
      <td>-0.2263</td>
      <td>0.174</td>
      <td>0.826</td>
      <td>0.000</td>
      <td>Sun Apr 29 01:13:32 +0000 2018</td>
      <td>BBC News (World)</td>
      <td>Hungary's dominant leader Orban defiant on kee...</td>
      <td>3</td>
    </tr>
    <tr>
      <th>3</th>
      <td>-0.4939</td>
      <td>0.286</td>
      <td>0.714</td>
      <td>0.000</td>
      <td>Sun Apr 29 01:10:30 +0000 2018</td>
      <td>BBC News (World)</td>
      <td>Nigerian Senator Dino Melaye and his many scan...</td>
      <td>4</td>
    </tr>
    <tr>
      <th>4</th>
      <td>0.0000</td>
      <td>0.000</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>Sun Apr 29 01:04:24 +0000 2018</td>
      <td>BBC News (World)</td>
      <td>Why you may have been eating insects your whol...</td>
      <td>5</td>
    </tr>
    <tr>
      <th>5</th>
      <td>-0.6486</td>
      <td>0.350</td>
      <td>0.650</td>
      <td>0.000</td>
      <td>Sun Apr 29 00:55:20 +0000 2018</td>
      <td>BBC News (World)</td>
      <td>Golden State Killer: The end of a 40-year hunt...</td>
      <td>6</td>
    </tr>
    <tr>
      <th>6</th>
      <td>-0.3400</td>
      <td>0.320</td>
      <td>0.469</td>
      <td>0.211</td>
      <td>Sun Apr 29 00:37:40 +0000 2018</td>
      <td>BBC News (World)</td>
      <td>Armenia crisis: Ruling party quits PM race htt...</td>
      <td>7</td>
    </tr>
    <tr>
      <th>7</th>
      <td>0.0000</td>
      <td>0.000</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>Sun Apr 29 00:02:26 +0000 2018</td>
      <td>BBC News (World)</td>
      <td>Can music bridge Thailand's sectarian divide? ...</td>
      <td>8</td>
    </tr>
    <tr>
      <th>8</th>
      <td>0.0000</td>
      <td>0.000</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>Sat Apr 28 23:53:56 +0000 2018</td>
      <td>BBC News (World)</td>
      <td>Chernobyl's new generation https://t.co/ZMzYDo...</td>
      <td>9</td>
    </tr>
    <tr>
      <th>9</th>
      <td>0.0000</td>
      <td>0.000</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>Sat Apr 28 23:30:39 +0000 2018</td>
      <td>BBC News (World)</td>
      <td>From Russian orphan to Team USA https://t.co/s...</td>
      <td>10</td>
    </tr>
    <tr>
      <th>10</th>
      <td>0.0000</td>
      <td>0.000</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>Sat Apr 28 23:27:28 +0000 2018</td>
      <td>BBC News (World)</td>
      <td>Brazilian Christians rebuild 'Satan's' temple ...</td>
      <td>11</td>
    </tr>
    <tr>
      <th>11</th>
      <td>0.0000</td>
      <td>0.000</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>Sat Apr 28 23:10:33 +0000 2018</td>
      <td>BBC News (World)</td>
      <td>First one-handed player joins NFL https://t.co...</td>
      <td>12</td>
    </tr>
    <tr>
      <th>12</th>
      <td>0.0000</td>
      <td>0.000</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>Sat Apr 28 21:58:55 +0000 2018</td>
      <td>BBC News (World)</td>
      <td>Burning Man founder Larry Harvey dies aged 70 ...</td>
      <td>13</td>
    </tr>
    <tr>
      <th>13</th>
      <td>-0.8957</td>
      <td>0.684</td>
      <td>0.316</td>
      <td>0.000</td>
      <td>Sat Apr 28 21:41:30 +0000 2018</td>
      <td>BBC News (World)</td>
      <td>Mali: Tuaregs killed in 'jihadist revenge' att...</td>
      <td>14</td>
    </tr>
    <tr>
      <th>14</th>
      <td>-0.7430</td>
      <td>0.391</td>
      <td>0.533</td>
      <td>0.077</td>
      <td>Sat Apr 28 21:16:09 +0000 2018</td>
      <td>BBC News (World)</td>
      <td>Pamplona rape case: Protests over sentence go ...</td>
      <td>15</td>
    </tr>
    <tr>
      <th>15</th>
      <td>-0.2960</td>
      <td>0.180</td>
      <td>0.820</td>
      <td>0.000</td>
      <td>Sat Apr 28 18:19:52 +0000 2018</td>
      <td>BBC News (World)</td>
      <td>Missing London rapper Kenny Mukendi 'threw him...</td>
      <td>16</td>
    </tr>
    <tr>
      <th>16</th>
      <td>0.5859</td>
      <td>0.000</td>
      <td>0.678</td>
      <td>0.322</td>
      <td>Sat Apr 28 18:19:52 +0000 2018</td>
      <td>BBC News (World)</td>
      <td>MSNBC's Joy Reid addresses homophobic blog pos...</td>
      <td>17</td>
    </tr>
    <tr>
      <th>17</th>
      <td>0.0000</td>
      <td>0.000</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>Sat Apr 28 16:54:24 +0000 2018</td>
      <td>BBC News (World)</td>
      <td>Row escalates over 'toxic' Trump pick for vete...</td>
      <td>18</td>
    </tr>
    <tr>
      <th>18</th>
      <td>0.0000</td>
      <td>0.000</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>Sat Apr 28 16:26:06 +0000 2018</td>
      <td>BBC News (World)</td>
      <td>Saudi Arabia 'sorry' for promotional footage o...</td>
      <td>19</td>
    </tr>
    <tr>
      <th>19</th>
      <td>0.5707</td>
      <td>0.000</td>
      <td>0.856</td>
      <td>0.144</td>
      <td>Sat Apr 28 14:58:50 +0000 2018</td>
      <td>BBC News (World)</td>
      <td>RT @BBCSteveR: Coming soon: I'm back at the pi...</td>
      <td>20</td>
    </tr>
    <tr>
      <th>20</th>
      <td>0.2960</td>
      <td>0.210</td>
      <td>0.455</td>
      <td>0.335</td>
      <td>Sat Apr 28 14:36:55 +0000 2018</td>
      <td>BBC News (World)</td>
      <td>Healthy Tasmanian devils discovered by scienti...</td>
      <td>21</td>
    </tr>
    <tr>
      <th>21</th>
      <td>0.0000</td>
      <td>0.000</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>Sat Apr 28 14:36:55 +0000 2018</td>
      <td>BBC News (World)</td>
      <td>Chinese firm Dalian Wanda opens $7.9bn 'movie ...</td>
      <td>22</td>
    </tr>
    <tr>
      <th>22</th>
      <td>-0.2960</td>
      <td>0.213</td>
      <td>0.662</td>
      <td>0.125</td>
      <td>Sat Apr 28 14:14:38 +0000 2018</td>
      <td>BBC News (World)</td>
      <td>Sumo wrestling: The growing sexism scandal in ...</td>
      <td>23</td>
    </tr>
    <tr>
      <th>23</th>
      <td>0.4215</td>
      <td>0.000</td>
      <td>0.763</td>
      <td>0.237</td>
      <td>Sat Apr 28 13:27:03 +0000 2018</td>
      <td>BBC News (World)</td>
      <td>Rescued bald eagle released into the wild in C...</td>
      <td>24</td>
    </tr>
    <tr>
      <th>24</th>
      <td>0.4215</td>
      <td>0.000</td>
      <td>0.823</td>
      <td>0.177</td>
      <td>Sat Apr 28 12:42:36 +0000 2018</td>
      <td>BBC News (World)</td>
      <td>Peter Norman: Sprinter involved in Black Power...</td>
      <td>25</td>
    </tr>
    <tr>
      <th>25</th>
      <td>0.5346</td>
      <td>0.141</td>
      <td>0.519</td>
      <td>0.340</td>
      <td>Sat Apr 28 11:56:07 +0000 2018</td>
      <td>BBC News (World)</td>
      <td>Korea summit: When war ends but peace is out o...</td>
      <td>26</td>
    </tr>
    <tr>
      <th>26</th>
      <td>-0.3612</td>
      <td>0.293</td>
      <td>0.526</td>
      <td>0.180</td>
      <td>Sat Apr 28 11:53:36 +0000 2018</td>
      <td>BBC News (World)</td>
      <td>Play as a refugee in Syrian war video game htt...</td>
      <td>27</td>
    </tr>
    <tr>
      <th>27</th>
      <td>0.0000</td>
      <td>0.000</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>Sat Apr 28 11:17:23 +0000 2018</td>
      <td>BBC News (World)</td>
      <td>Kanye West defends pro-Trump politics in new s...</td>
      <td>28</td>
    </tr>
    <tr>
      <th>28</th>
      <td>-0.6486</td>
      <td>0.415</td>
      <td>0.440</td>
      <td>0.145</td>
      <td>Sat Apr 28 10:11:45 +0000 2018</td>
      <td>BBC News (World)</td>
      <td>Myanmar violence: Thousands flee fresh fightin...</td>
      <td>29</td>
    </tr>
    <tr>
      <th>29</th>
      <td>0.0000</td>
      <td>0.000</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>Sat Apr 28 09:05:49 +0000 2018</td>
      <td>BBC News (World)</td>
      <td>Bangladesh's disappearing ear cleaners https:/...</td>
      <td>30</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>470</th>
      <td>0.0000</td>
      <td>0.000</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>Fri Apr 27 19:00:49 +0000 2018</td>
      <td>The New York Times</td>
      <td>To discredit Bill Cosby's accusers, his public...</td>
      <td>71</td>
    </tr>
    <tr>
      <th>471</th>
      <td>0.2023</td>
      <td>0.000</td>
      <td>0.921</td>
      <td>0.079</td>
      <td>Fri Apr 27 18:47:05 +0000 2018</td>
      <td>The New York Times</td>
      <td>RT @NYTSports: Why are the Angels going to a s...</td>
      <td>72</td>
    </tr>
    <tr>
      <th>472</th>
      <td>0.2924</td>
      <td>0.000</td>
      <td>0.886</td>
      <td>0.114</td>
      <td>Fri Apr 27 18:37:02 +0000 2018</td>
      <td>The New York Times</td>
      <td>President Trump said he would not be fooled by...</td>
      <td>73</td>
    </tr>
    <tr>
      <th>473</th>
      <td>0.0000</td>
      <td>0.000</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>Fri Apr 27 18:27:03 +0000 2018</td>
      <td>The New York Times</td>
      <td>RT @Jonesieman: Today's the 120th birthday of ...</td>
      <td>74</td>
    </tr>
    <tr>
      <th>474</th>
      <td>-0.4215</td>
      <td>0.286</td>
      <td>0.714</td>
      <td>0.000</td>
      <td>Fri Apr 27 18:17:02 +0000 2018</td>
      <td>The New York Times</td>
      <td>Bill Cosby was found guilty. What's next? http...</td>
      <td>75</td>
    </tr>
    <tr>
      <th>475</th>
      <td>-0.1280</td>
      <td>0.073</td>
      <td>0.927</td>
      <td>0.000</td>
      <td>Fri Apr 27 18:07:03 +0000 2018</td>
      <td>The New York Times</td>
      <td>T-Mobile and Sprint are said to be close to a ...</td>
      <td>76</td>
    </tr>
    <tr>
      <th>476</th>
      <td>0.0000</td>
      <td>0.000</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>Fri Apr 27 17:57:02 +0000 2018</td>
      <td>The New York Times</td>
      <td>President Trump has a chilly relationship with...</td>
      <td>77</td>
    </tr>
    <tr>
      <th>477</th>
      <td>0.0000</td>
      <td>0.000</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>Fri Apr 27 17:47:03 +0000 2018</td>
      <td>The New York Times</td>
      <td>What President Trump can expect from his trip ...</td>
      <td>78</td>
    </tr>
    <tr>
      <th>478</th>
      <td>0.0000</td>
      <td>0.000</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>Fri Apr 27 17:37:04 +0000 2018</td>
      <td>The New York Times</td>
      <td>"There are several high concepts, several over...</td>
      <td>79</td>
    </tr>
    <tr>
      <th>479</th>
      <td>0.0000</td>
      <td>0.000</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>Fri Apr 27 17:30:45 +0000 2018</td>
      <td>The New York Times</td>
      <td>Breaking News: Hundreds of Palestinians storme...</td>
      <td>80</td>
    </tr>
    <tr>
      <th>480</th>
      <td>-0.7184</td>
      <td>0.273</td>
      <td>0.727</td>
      <td>0.000</td>
      <td>Fri Apr 27 05:14:22 +0000 2018</td>
      <td>The New York Times</td>
      <td>Archaeologists in Sweden found victims of a 5t...</td>
      <td>81</td>
    </tr>
    <tr>
      <th>481</th>
      <td>-0.6597</td>
      <td>0.161</td>
      <td>0.839</td>
      <td>0.000</td>
      <td>Fri Apr 27 04:58:06 +0000 2018</td>
      <td>The New York Times</td>
      <td>RT @NYTNational: "This is not a club anyone re...</td>
      <td>82</td>
    </tr>
    <tr>
      <th>482</th>
      <td>-0.3818</td>
      <td>0.115</td>
      <td>0.885</td>
      <td>0.000</td>
      <td>Fri Apr 27 04:43:05 +0000 2018</td>
      <td>The New York Times</td>
      <td>Maria Bochkareva was one of Russia’s first fem...</td>
      <td>83</td>
    </tr>
    <tr>
      <th>483</th>
      <td>-0.6486</td>
      <td>0.235</td>
      <td>0.765</td>
      <td>0.000</td>
      <td>Fri Apr 27 04:29:07 +0000 2018</td>
      <td>The New York Times</td>
      <td>The identity of the Golden State Killer was di...</td>
      <td>84</td>
    </tr>
    <tr>
      <th>484</th>
      <td>-0.3612</td>
      <td>0.128</td>
      <td>0.872</td>
      <td>0.000</td>
      <td>Fri Apr 27 04:14:06 +0000 2018</td>
      <td>The New York Times</td>
      <td>RT @nytimesarts: How do I cleave Bill Cosby fr...</td>
      <td>85</td>
    </tr>
    <tr>
      <th>485</th>
      <td>0.0000</td>
      <td>0.000</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>Fri Apr 27 04:00:14 +0000 2018</td>
      <td>The New York Times</td>
      <td>Video: North Korea’s Kim Jong-un steps across ...</td>
      <td>86</td>
    </tr>
    <tr>
      <th>486</th>
      <td>0.0000</td>
      <td>0.000</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>Fri Apr 27 03:47:03 +0000 2018</td>
      <td>The New York Times</td>
      <td>A new spider family tree shows a massive netwo...</td>
      <td>87</td>
    </tr>
    <tr>
      <th>487</th>
      <td>0.0000</td>
      <td>0.000</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>Fri Apr 27 03:46:13 +0000 2018</td>
      <td>The New York Times</td>
      <td>For Catalans, a Day of Books, Roses and, of Co...</td>
      <td>88</td>
    </tr>
    <tr>
      <th>488</th>
      <td>0.0000</td>
      <td>0.000</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>Fri Apr 27 03:34:33 +0000 2018</td>
      <td>The New York Times</td>
      <td>Trump’s On-Again, Off-Again Trip to Britain Is...</td>
      <td>89</td>
    </tr>
    <tr>
      <th>489</th>
      <td>0.0000</td>
      <td>0.000</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>Fri Apr 27 03:32:04 +0000 2018</td>
      <td>The New York Times</td>
      <td>In his newest memoir, “Faith,” former Presiden...</td>
      <td>90</td>
    </tr>
    <tr>
      <th>490</th>
      <td>-0.2732</td>
      <td>0.110</td>
      <td>0.890</td>
      <td>0.000</td>
      <td>Fri Apr 27 03:17:02 +0000 2018</td>
      <td>The New York Times</td>
      <td>Scott Pruitt, the Environmental Protection Age...</td>
      <td>91</td>
    </tr>
    <tr>
      <th>491</th>
      <td>0.3612</td>
      <td>0.000</td>
      <td>0.884</td>
      <td>0.116</td>
      <td>Fri Apr 27 03:06:03 +0000 2018</td>
      <td>The New York Times</td>
      <td>“I don’t see evidence of the wages getting hig...</td>
      <td>92</td>
    </tr>
    <tr>
      <th>492</th>
      <td>-0.3400</td>
      <td>0.107</td>
      <td>0.893</td>
      <td>0.000</td>
      <td>Fri Apr 27 02:56:02 +0000 2018</td>
      <td>The New York Times</td>
      <td>The chaplain of the House said that he was bli...</td>
      <td>93</td>
    </tr>
    <tr>
      <th>493</th>
      <td>-0.3400</td>
      <td>0.094</td>
      <td>0.906</td>
      <td>0.000</td>
      <td>Fri Apr 27 02:51:00 +0000 2018</td>
      <td>The New York Times</td>
      <td>RT @thomaskaplan: "I was asked to resign, that...</td>
      <td>94</td>
    </tr>
    <tr>
      <th>494</th>
      <td>-0.8316</td>
      <td>0.315</td>
      <td>0.685</td>
      <td>0.000</td>
      <td>Fri Apr 27 02:47:01 +0000 2018</td>
      <td>The New York Times</td>
      <td>The FBI first gave the White House counsel a f...</td>
      <td>95</td>
    </tr>
    <tr>
      <th>495</th>
      <td>0.0000</td>
      <td>0.000</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>Fri Apr 27 02:33:06 +0000 2018</td>
      <td>The New York Times</td>
      <td>A former Manhattan judge will lead the review ...</td>
      <td>96</td>
    </tr>
    <tr>
      <th>496</th>
      <td>0.3182</td>
      <td>0.000</td>
      <td>0.875</td>
      <td>0.125</td>
      <td>Fri Apr 27 02:17:06 +0000 2018</td>
      <td>The New York Times</td>
      <td>RT @samdolnick: "Mr. Cosby told lots of jokes....</td>
      <td>97</td>
    </tr>
    <tr>
      <th>497</th>
      <td>0.1779</td>
      <td>0.000</td>
      <td>0.909</td>
      <td>0.091</td>
      <td>Fri Apr 27 02:02:06 +0000 2018</td>
      <td>The New York Times</td>
      <td>Amazon said it was raising the price of its Pr...</td>
      <td>98</td>
    </tr>
    <tr>
      <th>498</th>
      <td>0.0000</td>
      <td>0.000</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>Fri Apr 27 01:54:23 +0000 2018</td>
      <td>The New York Times</td>
      <td>RT @HirokoTabuchi: EPA Administrator Scott Pru...</td>
      <td>99</td>
    </tr>
    <tr>
      <th>499</th>
      <td>-0.3612</td>
      <td>0.116</td>
      <td>0.884</td>
      <td>0.000</td>
      <td>Fri Apr 27 01:41:05 +0000 2018</td>
      <td>The New York Times</td>
      <td>Proximity to President Trump has been crushing...</td>
      <td>100</td>
    </tr>
  </tbody>
</table>
<p>500 rows × 8 columns</p>
</div>




```python
news_df.to_csv("news df")
```


```python
average_sentiment = news_df.groupby("Tweet Source").mean()["Compound"]
average_sentiment
```




    Tweet Source
    BBC News (World)     -0.113774
    CBS News             -0.102114
    CNN                  -0.014316
    Fox News              0.152086
    The New York Times   -0.094131
    Name: Compound, dtype: float64




```python
# build a scatter plot
for index, row in news_df.iterrows():
    if row["Tweet Source"]=="BBC News (World)":
        plt.scatter(row["Tweets Ago"], row["Compound"], c="lightblue", alpha=1.0, edgecolor="black", marker=",")
    if row["Tweet Source"]=="CBS News":
        plt.scatter(row["Tweets Ago"], row["Compound"], c="green", alpha=1.0, edgecolor="black", marker=",")
    if row["Tweet Source"]=="CNN":
        plt.scatter(row["Tweets Ago"], row["Compound"], c="red", alpha=1.0, edgecolor="black", marker=",")
    if row["Tweet Source"]=="Fox News":
        plt.scatter(row["Tweets Ago"], row["Compound"], c="blue", alpha=1.0, edgecolor="black", marker=",")
    if row["Tweet Source"]=="The New York Times":
        plt.scatter(row["Tweets Ago"], row["Compound"], c="gold", alpha=1.0, edgecolor="black", marker=",")


# legend colors        
lightblue_patch = mpatches.Patch(color='lightblue', label='BBC')
green_patch = mpatches.Patch(color='green', label='CBS')
red_patch = mpatches.Patch(color='red', label='CNN')
blue_patch = mpatches.Patch(color='blue', label='Fox')
gold_patch = mpatches.Patch(color='gold', label='NYT')

# legend
date = time.strftime("%m/%d/%Y")
plt.title("Sentiment Analysis of Tweets (" + date + ")")
plt.xlabel("Tweets Ago")
plt.ylabel("Tweet Polarity")
lgd = plt.legend(handles=[lightblue_patch, green_patch, red_patch, blue_patch, gold_patch], loc='upper right', bbox_to_anchor=(1.2,1.0))

plt.gca().invert_xaxis()

plt.savefig("tweet polarity.png", bbox_extra_artists=(lgd,), bbox_inches='tight')
```


![png](output_7_0.png)



```python
# build a bar graph
x_axis = ("BBC", "CBS", "CNN", "Fox", "NYT")

plt.ylim(min(average_sentiment)-.05, max(average_sentiment)+.05)
plt.bar(x_axis, average_sentiment, color=("lightblue", "green", "red", "blue", "gold"), edgecolor = "black", align="center", width=1)
plt.ylabel("Tweet Polarity")
plt.title('Overall Media Sentiment Based on Twitter ('+date+')')

plt.savefig("overall media sentiment.png")

```


![png](output_8_0.png)

