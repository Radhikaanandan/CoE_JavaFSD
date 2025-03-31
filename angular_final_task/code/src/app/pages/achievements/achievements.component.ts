import { Component } from '@angular/core';
import { ApiService } from '../../services/api.service';
import { Achievement } from '../../model/achievement';

@Component({
  selector: 'app-achievements',
  templateUrl: './achievements.component.html',
  styleUrl: './achievements.component.css'
})
export class AchievementsComponent {
  achievements: Achievement[] = [];

  constructor(private as: ApiService) { }

  ngOnInit(): void {
    this.as.getAchievements().subscribe({
      next: (result: Achievement[]) => { this.achievements = result; },
      error: (err: any) => { console.log(err); }
    });
  }

}
