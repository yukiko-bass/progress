//
//  ViewController.m
//  progress
//
//  Created by CatenaRentalSystem on 13/04/19.
//  Copyright (c) 2013年 CatenaRentalSystem. All rights reserved.
//

#import "ViewController.h"

#define PROGRESS_STEP_TIME 0.05


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *speedSegment;
@property (weak, nonatomic) IBOutlet UISwitch *repeateSwitch;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIProgressView *timeProgress;
@property (nonatomic) float progressTimer;
@property (nonatomic) float performanceTime;
@property (nonatomic) BOOL inProgress;


- (IBAction)speedChanged:(id)sender;
- (IBAction)touchStartButton:(id)sender;

@end

@implementation ViewController

static float performanceTimes[] = {0.5, 5.0};

- (void) initProgress {
    _inProgress = NO;
    _speedSegment.selectedSegmentIndex = 0;
    _performanceTime = performanceTimes[_speedSegment.selectedSegmentIndex];
    _repeateSwitch.on = NO;
    _timeProgress.progress = 0.0;
}

- (void)startProgress {
    _timeProgress.progress = _progressTimer;
    _inProgress = YES;
    [_startButton setTitle:@"Stop" forState:UIControlStateNormal];
    [self performSelector:@selector(updateProgress) withObject:nil afterDelay:PROGRESS_STEP_TIME];
}

- (void)stopProgress {
    _inProgress = NO;
    [_startButton setTitle:@"Start" forState:UIControlStateNormal];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (void)updateProgress {
    _progressTimer += PROGRESS_STEP_TIME;
    _timeProgress.progress = _progressTimer / _performanceTime;
    if (_progressTimer < _progressTimer) {
        [self performSelector:@selector(updateProgress) withObject:nil afterDelay:PROGRESS_STEP_TIME];
    } else {
        [self stopProgress];
        if (_repeateSwitch.on) {
            [self startProgress];
        }
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initProgress];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)speedChanged:(id)sender {
    _progressTimer = performanceTimes[_speedSegment.selectedSegmentIndex];
}

- (IBAction)touchStartButton:(id)sender {
    if (_inProgress) {
        [self stopProgress];
    } else {
        [self startProgress];
    }
}
@end
