/*******************************************************************************
 * Copyright (c) 2011, Jean-David Gadina - www.xs-labs.com
 * Distributed under the Boost Software License, Version 1.0.
 * 
 * Boost Software License - Version 1.0 - August 17th, 2003
 * 
 * Permission is hereby granted, free of charge, to any person or organization
 * obtaining a copy of the software and accompanying documentation covered by
 * this license (the "Software") to use, reproduce, display, distribute,
 * execute, and transmit the Software, and to prepare derivative works of the
 * Software, and to permit third-parties to whom the Software is furnished to
 * do so, all subject to the following:
 * 
 * The copyright notices in the Software and this entire statement, including
 * the above license grant, this restriction and the following disclaimer,
 * must be included in all copies of the Software, in whole or in part, and
 * all derivative works of the Software, unless such copies or derivative
 * works are solely in the form of machine-executable object code generated by
 * a source language processor.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT
 * SHALL THE COPYRIGHT HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE
 * FOR ANY DAMAGES OR OTHER LIABILITY, WHETHER IN CONTRACT, TORT OR OTHERWISE,
 * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 ******************************************************************************/
 
/* $Id$ */

/*!
 * @file        ...
 * @copyright   (c) 2012 - Jean-David Gadina - www.xs-labs.com
 * @abstract    ...
 */

#import "DMFileSystemPartitionTableViewController+UITableViewDataSource.h"
#import "DMFileSystemPartitionTableViewCell.h"
#import "DMGroupedTableViewCellBackgroundView.h"

@implementation DMFileSystemPartitionTableViewController( UITableViewDataSource )

- ( NSInteger )numberOfSectionsInTableView: ( UITableView * )tableView
{
    ( void )tableView;
    
    return 1;
}

- ( NSInteger )tableView: ( UITableView * )tableView numberOfRowsInSection: ( NSInteger )section
{
    ( void )tableView;
    ( void )section;
    
    return ( NSInteger )[ _partitions count ];
}

- ( UITableViewCell * )tableView: ( UITableView * )tableView cellForRowAtIndexPath: ( NSIndexPath * )indexPath
{
    DMGroupedTableViewCellBackgroundView * backgroundView;
    DMFileSystemPartitionTableViewCell   * cell;
    
    cell = ( DMFileSystemPartitionTableViewCell * )[ tableView dequeueReusableCellWithIdentifier: DMFileSystemPartitionTableViewCellID ];
    
    if( cell == nil || [ cell isKindOfClass: [ DMFileSystemPartitionTableViewCell class ] ] == NO )
    {
        cell = [ [ DMFileSystemPartitionTableViewCell new ] autorelease ];
    }
    
    @try
    {
        cell.partition = [ _partitions objectAtIndex: indexPath.row ];
    }
    @catch ( NSException * e )
    {
        ( void )e;
        
        cell.partition = nil;
    }
    
    backgroundView                      = [ [ [ DMGroupedTableViewCellBackgroundView alloc ] initWithFrame: CGRectZero ] autorelease ];
    backgroundView.backgroundViewType   = DMGroupedTableViewCellBackgroundViewTypeMiddle;
    backgroundView.fillColor            = [ UIColor colorWithPatternImage: [ UIImage imageNamed: @"RootTable-CellBackground.png" ] ];
    cell.textLabel.backgroundColor      = [ UIColor clearColor ];
    
    if( _partitions.count == 1 )
    {
        backgroundView.backgroundViewType = DMGroupedTableViewCellBackgroundViewTypeSingle;
    }
    else if( indexPath.row == 0 )
    {
        backgroundView.backgroundViewType = DMGroupedTableViewCellBackgroundViewTypeTop;
    }
    else if( ( NSUInteger )( indexPath.row + 1 ) == _partitions.count )
    {
        backgroundView.backgroundViewType = DMGroupedTableViewCellBackgroundViewTypeBottom;
    }
    else
    {
        backgroundView.backgroundViewType = DMGroupedTableViewCellBackgroundViewTypeMiddle;
    }
    
    cell.backgroundView = backgroundView;
    
    return cell;
}

- ( NSString * )tableView: ( UITableView * )tableView titleForHeaderInSection: ( NSInteger )section
{
    ( void )tableView;
    ( void )section;
    
    return NSLocalizedString( @"MountPoints", @"MountPoints" );
}

@end
