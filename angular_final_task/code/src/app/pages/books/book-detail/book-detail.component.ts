import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { ApiService } from '../../../services/api.service'; 

@Component({
  selector: 'app-book-detail',
  templateUrl: './book-detail.component.html',
  styleUrls: ['./book-detail.component.css']
})
export class BookDetailComponent implements OnInit {
  id: string = '';               
  bookDetail: any = null;        
  preview: string[] = [];        

  constructor(
    private route: ActivatedRoute,  
    private api: ApiService         
  ) {
   
    this.id = this.route.snapshot.paramMap.get('id') || '';
  }

  ngOnInit(): void {
    if (this.id) {
      this.api.getDetail(this.id).subscribe({
        next: (result: any) => {
          if (result && result.length > 0) {
            this.bookDetail = result[0];  // Store the full book detail
            this.preview = result[0].preview;  // Store the preview (array of strings)
          }
        },
        error: (error: any) => console.error('API Error:', error)
      });
    }
  }
}
