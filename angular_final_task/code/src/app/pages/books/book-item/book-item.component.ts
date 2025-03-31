import { Component, Input } from '@angular/core';
import { Router } from '@angular/router';
import { Book } from '../../../model/book';

@Component({
  selector: 'app-book-item',
  templateUrl: './book-item.component.html',
  styleUrls: ['./book-item.component.css']  // Corrected this line
})
export class BookItemComponent {
  @Input() book: Book = {
    id: '',
    title: '',
    description: '',
    coverImage: '',
    author: '',
    publicationYear: '',
    genres: ''
  };

  constructor(private router: Router) {}

  onBookClick(id: string) {
    this.router.navigate(['/books', id], { state: { title: this.book.title } });
  }
}
