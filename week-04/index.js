const generalBtn=document.getElementById("General");
const businessBtn=document.getElementById("business");
const sportsBtn=document.getElementById("sport");
const entertainmentBtn=document.getElementById("entertainment");
const searchBtn=document.getElementById("searchBtn");
const technologyBtn=document.getElementById("technology");

const newsQuery=document.getElementById("newsQuery");
const newsType=document.getElementById("newsType");
const newsdetails=document.getElementById("newsdetails");

var newsDataArr=[];

const API_KEY ="7d58288a4dac48599a154324dfb0e9f5";
const HEADLINES_NEWS = "https://newsapi.org/v2/top-headlines?country=us&apiKey=7d58288a4dac48599a154324dfb0e9f5";
const GENERAL_NEWS = "https://newsapi.org/v2/top-headlines?country=us&category=general&apiKey=7d58288a4dac48599a154324dfb0e9f5";
const BUSINESS_NEWS = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=7d58288a4dac48599a154324dfb0e9f5";
const SPORTS_NEWS = "https://newsapi.org/v2/top-headlines?country=us&category=sports&apiKey=7d58288a4dac48599a154324dfb0e9f5";
const ENTERTAINMENT_NEWS = "https://newsapi.org/v2/top-headlines?country=us&category=entertainment&apiKey=7d58288a4dac48599a154324dfb0e9f5";
const TECHNOLOGY_NEWS = "https://newsapi.org/v2/top-headlines?country=us&category=technology&pageSize=8&apiKey=7d58288a4dac48599a154324dfb0e9f5";
const SEARCH_NEWS = "https://newsapi.org/v2/everything?q=";

window.onload=function(){
    newsType.innerHTML="<h4>Headlines</h4>";
    fetchHeadlines();

};
generalBtn.addEventListener("click",function(){
    newsType.innerHTML="<h4>General news</h4>";
    fetchGeneralNews();

});

businessBtn.addEventListener("click",function(){
   newsType.innerHTML="<h4>Business</h4>";
     fetchBusinessNews();
});

sportsBtn.addEventListener("click",function(){
   newsType.innerHTML="<h4>Sports</h4>";
    fetchSportNews();
});

entertainmentBtn.addEventListener("click",function(){
    newsType.innerHTML="<h4>Entertainment</h4>";
    fetchEntertainmentNews();

});

technologyBtn.addEventListener("click",function(){
    newsType.innerHTML="<h4>Technology</h4>";
    fetchTechnologyNews();

});

searchBtn.addEventListener("click",function(){
    newsType.innerHTML="<h4>Search:"+newsQuery.value+"</h4>";
    fetchQueryNews();

});

const fetchHeadlines= async () => {
    const response = await fetch(HEADLINES_NEWS);
    if(response.status>=200 && response.status<300 )
    {
        const myJson =await response.json();
        newsDataArr=myJson.articles;
    }else{
       
        console.log(response.status, response.statusText);

    }
    displayNews();
}

const fetchGeneralNews= async () => {
    const response = await fetch(GENERAL_NEWS);
    if(response.status>=200 && response.status<300 )
    {
        const myJson =await response.json();
        newsDataArr=myJson.articles;
    }else{
       
        console.log(response.status, response.statusText);

    }
    displayNews();
}

const fetchBusinessNews = async () => {
    const response = await fetch(BUSINESS_NEWS);
    newsDataArr = [];
    if(response.status>=200 && response.status<300 )
    {
        const myJson =await response.json();
        newsDataArr=myJson.articles;
    }else{
       
        console.log(response.status, response.statusText);

    }
    displayNews();
}

const fetchSportNews= async () => {
    const response = await fetch(SPORTS_NEWS);
    newsDataArr = [];
    if(response.status>=200 && response.status<300 )
    {
        const myJson =await response.json();
        newsDataArr=myJson.articles;
    }else{
       
        console.log(response.status, response.statusText);

    }
    displayNews();
}

const fetchEntertainmentNews= async () => {
    const response = await fetch(ENTERTAINMENT_NEWS);
    newsDataArr = [];
    if(response.status>=200 && response.status<300 )
    {
        const myJson =await response.json();
        console.log(myJson);
        newsDataArr=myJson.articles;
    }else{
        
        console.log(response.status, response.statusText);

    }
    displayNews();
}

const fetchTechnologyNews= async () => {
    const response = await fetch(TECHNOLOGY_NEWS);
    newsDataArr = [];
    if(response.status>=200 && response.status<300 )
    {
        const myJson =await response.json();
        newsDataArr=myJson.articles;
    }else{
        
        console.log(response.status, response.statusText);

    }
    displayNews();
}

const fetchQueryNews= async () => {
    if(!newsQuery.value)return;


    const response = await fetch(SEARCH_NEWS + encodeURIComponent(newsQuery.value)+"&apiKey="+ API_KEY);
    newsDataArr=[];
    if(response.status>=200 && response.status<300 )
    {
        const myJson =await response.json();
        newsDataArr=myJson.articles;
    }else{
        console.log(response.status, response.statusText);

    }
    displayNews();
}

function displayNews(){
    newsdetails.innerHTML = "";
    if(newsDataArr.length == 0) {
        newsdetails.innerHTML = "<h5>No data found.</h5>";
        return;
    }
    
    newsDataArr.forEach((news, index) => {
        var date = news.publishedAt.split("T");

        var col = document.createElement('div');
        col.className = "col-sm-12 col-md-4 col-lg-3 p-2 card";

        var card = document.createElement('div');
        card.className = "p-2";

        var image = document.createElement('img');
        image.setAttribute("height", "matchparent");
        image.setAttribute("width", "100%");
        image.src = news.urlToImage;

        var cardBody = document.createElement('div');

        var newsHeading = document.createElement('h5');
        newsHeading.className = "card-title";
        newsHeading.innerHTML = news.title;

        var dateHeading = document.createElement('h6');
        dateHeading.className = "text-primary";
        dateHeading.innerHTML = date[0];

        var description = document.createElement('p');
        description.className = "text-muted";
        description.innerHTML = news.description;

        var link = document.createElement('a');
        link.className = "btn btn-dark";
        link.setAttribute("target", "_blank");
        link.href = news.url;
        link.innerHTML = "Read more";

        var shareBtn = document.createElement('button');
        shareBtn.className = "btn btn-warning mt-2";
        shareBtn.innerHTML = "Share";
        shareBtn.onclick = function() {
            navigator.clipboard.writeText(news.url);
            alert("Link copied to clipboard!");
        };

        var commentInput = document.createElement('input');
        commentInput.type = "text";
        commentInput.className = "form-control mt-2";
        commentInput.placeholder = "Write a comment...";
        commentInput.setAttribute("data-index", index);

        var commentBtn = document.createElement('button');
        commentBtn.className = "btn btn-primary mt-2";
        commentBtn.innerHTML = "Post Comment";
        commentBtn.onclick = function() {
            postComment(index, commentInput.value);
            commentInput.value = "";
        };

        var commentSection = document.createElement('div');
        commentSection.className = "comments mt-2";
        commentSection.setAttribute("id", `comments-${index}`);

        cardBody.appendChild(newsHeading);
        cardBody.appendChild(dateHeading);
        cardBody.appendChild(description);
        cardBody.appendChild(link);
        cardBody.appendChild(shareBtn);
        cardBody.appendChild(commentInput);
        cardBody.appendChild(commentBtn);
        cardBody.appendChild(commentSection);

        card.appendChild(image);
        card.appendChild(cardBody);

        col.appendChild(card);
        newsdetails.appendChild(col);
    });
}
const commentsData = {};  
function postComment(index, comment) {
    if (!comment.trim()) return;
    
    if (!commentsData[index]) commentsData[index] = [];
    commentsData[index].push(comment);

    displayComments(index);
}
function displayComments(index) {
    let commentSection = document.getElementById(`comments-${index}`);
    commentSection.innerHTML = "";
    
    commentsData[index].forEach(comment => {
        let commentDiv = document.createElement('div');
        commentDiv.className = "comment-box p-2 bg-light mt-1";
        commentDiv.innerHTML = comment;
        commentSection.appendChild(commentDiv);
    });
}
