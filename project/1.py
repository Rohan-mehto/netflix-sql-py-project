import pandas as pd
import matplotlib.pyplot as plt


df=pd.read_csv('netflix_titles.csv')
df=df.dropna(subset=['type','release_year','rating','country','duration'])
type_counts=df['type'].value_counts()
plt.figure(figsize=(6,4))
plt.bar(type_counts.index,type_counts.values,color=['skyblue','orange'])
plt.xlabel('Type')
plt.ylabel('Count')
plt.tight_layout()
plt.savefig('movies_vs_tvshows.png')
plt.show()

rating_counts=df['rating'].value_counts()
plt.figure(figsize=(8,6))
plt.pie(rating_counts,labels=rating_counts.index,autopct='%1.1f%%',startangle=90)
plt.title('Percentage of Content Ratings')
plt.tight_layout()
plt.savefig('rating_pie_chart.png')
plt.show()


movie_df=df[df['type']=='Movie'].copy()
movie_df['duration_int']=movie_df['duration'].str.replace('min','').astype(int)
plt.figure(figsize=(8,6))
plt.hist(movie_df['duration_int'],bins=30,color='purple',edgecolor='black')
plt.title('Distribution of Movie Durations')
plt.xlabel('Duration (minutes)')
plt.ylabel('Number of Movies')
plt.tight_layout()
plt.savefig('movies_druaton_hist.png')
plt.show()

relase_counts=df['release_year'].value_counts().sort_index()
plt.figure(figsize=(10,6))
plt.scatter(relase_counts.index,relase_counts.values,color='red')
plt.title('Release Year Vs Number of shows')
plt.xlabel('Release Year')
plt.ylabel('Number of shows')
plt.tight_layout()
plt.savefig('release_year_scatter.png')
plt.show()


country_counts=df['country'].value_counts().head(10)
plt.figure(figsize=(10,6))
plt.barh(country_counts.index,country_counts.values,color='teal')
plt.title('top 10 countries with most content')
plt.xlabel('Number of shows')
plt.ylabel('country')
plt.tight_layout()
plt.savefig('top_10_countries.png')
plt.show()



content_by_year=df.groupby(['release_year','type']).size().unstack().fillna(0)

fig,ax=plt.subplots(1,2,figsize=(12,5))
ax[0].plot(content_by_year.index,content_by_year['Movie'],color='blue')
ax[0].set_title('Movie Content by Year')
ax[0].set_xlabel('Year')
ax[0].set_ylabel('Number of Movies')

#second subplot :tv shows
ax[0].plot(content_by_year.index,content_by_year['TV Show'],color='orange')
ax[0].set_xlabel('Year')
ax[0].set_ylabel('Number of TV Shows')

fig.suptitle('comparison of Movies and Tv shows Released over years')

plt.tight_layout()
plt.savefig('movies_tv_shows.png')
plt.show()