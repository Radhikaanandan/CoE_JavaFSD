import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { HomeComponent } from './pages/home/home.component';
import { AboutmeComponent } from './pages/aboutme/aboutme.component';
import { AchievementsComponent } from './pages/achievements/achievements.component';
import { BooksComponent } from './pages/books/books.component';
import { ContactComponent } from './pages/contact/contact.component';
import { BookDetailComponent } from './pages/books/book-detail/book-detail.component'; 
import { EnquiryComponent } from './pages/enquiry/enquiry.component';
import { LoginComponent } from './common/login/login.component';
import { AuthGuard } from './guards/auth.guard'; 
const routes: Routes = [
  { path: '', component: HomeComponent },
  { path: 'about-me', component: AboutmeComponent },
  { path: 'achievements', component: AchievementsComponent},
  { path: 'books', component: BooksComponent },
  { path: 'contact', component: ContactComponent },
  { path: 'books/:id', component: BookDetailComponent },
  { path: 'enquiry', component: EnquiryComponent, canActivate: [AuthGuard]},
  { path: 'login', component: LoginComponent }

];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
