;;; Copyright (c) 2013, Jan Winkler <winkler@cs.uni-bremen.de>
;;; All rights reserved.
;;; 
;;; Redistribution and use in source and binary forms, with or without
;;; modification, are permitted provided that the following conditions are met:
;;; 
;;;     * Redistributions of source code must retain the above copyright
;;;       notice, this list of conditions and the following disclaimer.
;;;     * Redistributions in binary form must reproduce the above copyright
;;;       notice, this list of conditions and the following disclaimer in the
;;;       documentation and/or other materials provided with the distribution.
;;;     * Neither the name of Willow Garage, Inc. nor the names of its
;;;       contributors may be used to endorse or promote products derived from
;;;       this software without specific prior written permission.
;;; 
;;; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
;;; AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
;;; IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
;;; ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
;;; LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
;;; CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
;;; SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
;;; INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
;;; CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
;;; ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
;;; POSSIBILITY OF SUCH DAMAGE.

(in-package :visibility-costmap)

(defmethod costmap-generator-name->score ((name (eql 'occlusion-distribution)))
  8)

(def-fact-group visibility-costmap (desig-costmap
                                    desig-z-value)

  (<- (desig-costmap ?desig ?cm)
    (desig-prop ?desig (occluded-by ?obj-name))
    (costmap ?cm)
    (semantic-map-objects ?objects)
    (costmap-add-function occlusion-distribution
                          (make-semantic-visibility-costmap
                           ?objects
                           :robot T
                           :occluding-object ?obj-name)
                          ?cm))

  (<- (desig-costmap ?desig ?cm)
    (desig-prop ?desig (visible-for robot))
    (costmap ?cm)
    (semantic-map-objects ?objects)
    (costmap-add-function table-distribution
                          (make-semantic-visibility-costmap
                           ?objects
                           :robot T)
                          ?cm))

  (<- (desig-costmap ?desig ?cm)
    (desig-prop ?desig (invisible-for robot))
    (costmap ?cm)
    (semantic-map-objects ?objects)
    (costmap-add-function table-distribution
                          (make-semantic-visibility-costmap
                           ?objects
                           :robot T
                           :invert T)
                          ?cm))

  (<- (desig-costmap ?desig ?cm)
    (desig-prop ?desig (visible-from ?pose))
    (costmap ?cm)
    (semantic-map-objects ?objects)
    (costmap-add-function table-distribution
                          (make-semantic-visibility-costmap
                           ?objects
                           :pose ?pose)
                          ?cm))

  (<- (desig-costmap ?desig ?cm)
    (desig-prop ?desig (invisible-from ?pose))
    (costmap ?cm)
    (semantic-map-objects ?objects)
    (costmap-add-function table-distribution
                          (make-semantic-visibility-costmap
                           ?objects
                           :pose ?pose
                           :invert T)
                          ?cm)))