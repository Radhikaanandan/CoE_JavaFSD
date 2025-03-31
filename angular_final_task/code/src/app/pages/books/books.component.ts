import { Component } from '@angular/core';
import { ApiService } from '../../services/api.service';
import { Book } from '../../model/book';

@Component({
  selector: 'app-books',
  templateUrl: './books.component.html',
  styleUrls: ['./books.component.css']
})
export class BooksComponent {
  bookList: Book[] = [];
  selectedGenre: string = 'All';
  genres: string[] = ['All', 'Fiction', 'Horror', 'Mystery', 'Suspense', 'Short story'];

  constructor(private api: ApiService) {}

  ngOnInit(): void {
    this.api.getBook().subscribe({
      next: (data: any) => this.bookList = data,
      error: (err: any) => console.error(err)
    });
  }
}
