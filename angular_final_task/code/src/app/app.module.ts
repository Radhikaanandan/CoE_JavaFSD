import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { HomeComponent } from './pages/home/home.component';
import { BooksComponent } from './pages/books/books.component';
import { ContactComponent } from './pages/contact/contact.component';
import { MenuBarComponent } from './common/menu-bar/menu-bar.component';
import { HttpClientModule } from '@angular/common/http';
import { AboutmeComponent } from './pages/aboutme/aboutme.component';
import { AchievementsComponent } from './pages/achievements/achievements.component';
import { BookItemComponent } from './pages/books/book-item/book-item.component';
import { BookDetailComponent } from './pages/books/book-detail/book-detail.component';
import { FormsModule } from '@angular/forms';
import { EnquiryComponent } from './pages/enquiry/enquiry.component';
import { LoginComponent } from './common/login/login.component';
import { TitleCasePipe } from './title-case.pipe';
import { GenreFilterPipe } from './pipes/genre-filter.pipe';


@NgModule({
  declarations: [
    AppComponent,
    HomeComponent,
    BooksComponent,
    AchievementsComponent,
    ContactComponent,
    MenuBarComponent,
    AboutmeComponent,
    AchievementsComponent,
    BookItemComponent,
    BookDetailComponent,
    EnquiryComponent,
    LoginComponent,
    TitleCasePipe,
    GenreFilterPipe
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    FormsModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
