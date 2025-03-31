import { Pipe, PipeTransform } from '@angular/core';
import { Book } from '../model/book';

@Pipe({
  name: 'genreFilter'
})
export class GenreFilterPipe implements PipeTransform {
  transform(books: Book[], selectedGenre: string): Book[] {
    if (!selectedGenre || selectedGenre === 'All') {
      return books;
    }
    return books.filter(book =>
      book.genres.toLowerCase().includes(selectedGenre.toLowerCase())
    );
  }
}
